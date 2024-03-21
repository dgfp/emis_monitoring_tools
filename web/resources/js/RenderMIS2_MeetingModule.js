/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var renderMIS2 = function (data, providers, json, mis2, lmis) {
    console.log(data, providers, json, mis2, lmis);
    return false;
    submissionDate = data.submissionDate
    var providerName = $("#provCode :selected").text().replace(/\s?[\[\d\]]/g, '');
    $("#providerName").html("&nbsp;&nbsp;<b>" + providerName + "</b>");
    if (submissionDate === undefined) {
        submissionDate = "........................................";
    } else {
        submissionDate = e2b(convertToUserDate(submissionDate));
    }
    $("#submissionDate").html("&nbsp;&nbsp;&nbsp;&nbsp;<b>" + submissionDate + "</b>");

//    mis2.setArea($.app.monthBangla[$('#month').val()] + "/ " + e2b($('#year option:selected').text()) + " ইং", $('#union option:selected').text().split("[")[0], $('#upazila option:selected').text().split("[")[0], $('#district option:selected').text().split("[")[0]);
//    mis2.cleanMIS2();

    var cal = new Calc(json);
    $('#totalWorker').html(e2b(providers.length));
    $('#totalSubmittedWorker').html(e2b(json.length));

    $('#r_unit_all_total_tot1').html(e2b(finiteFilter(cal.sum.r_unit_all_total_tot)));
    $('#r_unit_capable_elco_tot1').html(e2b(finiteFilter(cal.sum.r_unit_capable_elco_tot)));
    var car = ((cal.sum.r_unit_all_total_tot / cal.sum.r_unit_capable_elco_tot) * 100).toFixed(2);
    $('#car').html(e2b(finiteFilter(car)));

    var one = "-";
    for (var j = 0; j < providers.length; j++) {
        var isSubmitted = false;
        var fpiIndex = 0;
        var fpiSubmittedJson = data.fpiSubmittedJson;

        $.each(fpiSubmittedJson, function (index, v) {
            if (providers[j].fwaunit == v.unit) {
                fpiData.nsv_inspired_fpi = v.nsv_inspired_fpi;
                fpiData.av_van_display_fpi = v.av_van_display_fpi;
                fpiData.elco_day_count_fpi = v.elco_day_count_fpi;
                fpiData.no_of_elco_count_fpi = v.no_of_elco_count_fpi;
                fpiData.fwa_register_fpi = v.fwa_register_fpi;
                fpiData.yard_meeting_fpi = v.yard_meeting_fpi;
                fpiData.fortnightly_meeting_fpi = v.fortnightly_meeting_fpi;
                fpiData.union_fp_committee_fpi = v.union_fp_committee_fpi;
                fpiData.satellite_clinic_presence_fpi = v.satellite_clinic_presence_fpi;
            }
        });

        for (var i = 0; i < json.length; i++) {
            json[i].aaaaaaaaaaaaa = 0;
            if (providers[j].fwaunit == json[i].r_unit) {

                isSubmitted = true;
                var Page1 = "<tr>"
                        + "<td>" + $.getUnitName(json[i].r_unit, 1) + "</td>"
                        + "<td>" + e2b(json[i].r_unit_capable_elco_tot) + "</td>"
                        + "<td>" + e2b(json[i].r_old_pill_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_new_pill_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_pill_normal_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_left_no_method_pill_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_pill_oth_method_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_old_pill_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_new_pill_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_pill_after_delivery_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_left_no_method_pill_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_pill_oth_method_after_delivery) + "</td>"
                        + "<td>" + json[i].r_curr_m_left_ppfp_expired_pill_after_delivery + "</td>"
                        + "<td>" + e2b(json[i].r_pill_total) + "</td>"
                        + "<td>" + e2b(json[i].r_old_condom_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_new_condom_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_condom_normal_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_left_no_method_condom_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_condom_oth_method_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_old_condom_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_new_condom_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_condom_after_delivery_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_left_no_method_condom_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_condom_oth_method_after_delivery) + "</td>"
                        + "<td>" + json[i].r_curr_m_left_ppfp_expired_condom_after_delivery + "</td>"
                        + "<td>" + e2b(json[i].r_condom_total) + "</td>"
                        + "<td>" + e2b(json[i].r_old_inject_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_new_inject_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_inject_normal_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_left_no_method_inject_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_inj_oth_method_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_old_inject_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_new_inject_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_inject_after_delivery_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_left_no_method_inject_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_inj_oth_method_after_delivery) + "</td>"
                        + "<td>" + json[i].r_curr_m_left_ppfp_expired_inject_after_delivery + "</td>"
                        + "<td>" + e2b(json[i].r_injectable_total) + "</td>"
                        + "</tr>";
                $('#mis2Page1').append(Page1);

                var Page2 = "<tr>"
                        + "<td>" + $.getUnitName(json[i].r_unit, 1) + "</td>"
                        + "<td>" + e2b(json[i].r_old_iud_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_new_iud_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_iud_normal_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_left_no_method_iud_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_iud_oth_method_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_old_iud_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_new_iud_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_iud_after_delivery_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_left_no_method_iud_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_iud_oth_method_after_delivery) + "</td>"
                        + "<td>" + json[i].r_curr_m_left_ppfp_expired_iud_after_delivery + "</td>"
                        + "<td>" + e2b(json[i].r_iud_total) + "</td>"
                        + "<td>" + e2b(json[i].r_old_implant_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_new_implant_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_implant_normal_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_left_no_method_implant_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_implant_oth_method_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_old_implant_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_new_implant_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_implant_after_delivery_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_left_no_method_implant_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_implant_oth_method_after_delivery) + "</td>"
                        + "<td>" + json[i].r_curr_m_left_ppfp_expired_implan_after_delivery + "</td>"
                        + "<td>" + e2b(json[i].r_implant_total) + "</td>"
                        + "<td>" + e2b(json[i].r_old_permanent_man_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_new_permanent_man_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_permanent_normal_man) + "</td>"
                        + "<td>" + e2b(json[i].r_old_permanent_man_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_new_permanent_man_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_permanent_after_delivery_man) + "</td>"
                        + "<td>" + e2b(json[i].r_permanent_method_men_total) + "</td>"
                        + "<td>" + e2b(json[i].r_old_permanent_woman_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_new_permanent_woman_normal) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_permanent_normal_woman) + "</td>"
                        + "<td>" + e2b(json[i].r_old_permanent_woman_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_new_permanent_woman_after_delivery) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_permanent_after_delivery_woman) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_left_ppfp_expired_all_tot) + "</td>"
                        + "<td>" + e2b(json[i].r_total_permanent_method) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_normal_total) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_after_delivery_total) + "</td>"
                        + "<td>" + e2b(json[i].r_unit_all_total_tot) + "</td>"
                        + "<td>" + e2b(json[i].r_car) + "</td>"
                        + "</tr>";
                $('#mis2Page2').append(Page2);

                var Page3 = "<tr>"
                        + "<td>" + $.getUnitName(json[i].r_unit, 1) + "</td>"
                        + "<td>" + e2b(json[i].r_sent_method_all_tot) + "</td>"
                        + "<td>" + e2b(json[i].r_sent_side_effect_all_tot) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_shown_capable_elco_tot) + "</td>"
                        + "<td>" + e2b(json[i].r_priv_m_shown_capable_elco_tot) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_m_v_new_elco_tot) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_preg_new_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_preg_old_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_curr_month_preg_tot_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_priv_month_tot_preg_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_unit_tot_preg_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_abortion_or_miscarriage) + "</td>"
                        + "<td>" + e2b(json[i].r_preg_anc_service_visit1_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_preg_anc_service_visit2_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_preg_anc_service_visit3_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_preg_anc_service_visit4_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_preg_anc_counselling_after_delivery_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_preg_anc_misoprostol_supplied_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_preg_anc_chlorohexidin_supplied_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_delivary_service_home_trained_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_delivary_service_home_untrained_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_delivary_service_hospital_normal_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_delivary_service_hospital_operation_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_delivary_service_misoprostol_taken) + "</td>"
                        + "<td>" + e2b(json[i].r_pnc_mother_visit1_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_pnc_mother_visit2_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_pnc_mother_visit3_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_pnc_mother_visit4_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_pnc_mother_home_delivery_training_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_pnc_mother_family_planning_counselling_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_newborn_1min_washed_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_newborn_71_chlorohexidin_used_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_newborn_with_mother_skin_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_newborn_1hr_bfeeded_fwa) + "</td>"
                        + "<td>" + e2b(json[i].r_newborn_diff_breathing_resassite_fwa) + "</td>"
                        + "</tr>";
                $('#mis2Page3').append(Page3);

                var Page4 = "<tr>"
                        + "<td>" + $.getUnitName(json[i].r_unit, 1) + "</td>"
                        + "<td>" + json[i].r_pnc_newborn_visit1_fwa + "</td>"
                        + "<td>" + json[i].r_pnc_newborn_visit2_fwa + "</td>"
                        + "<td>" + json[i].r_pnc_newborn_visit3_fwa + "</td>"
                        + "<td>" + json[i].r_pnc_newborn_visit4_fwa + "</td>"
                        + "<td>" + json[i].r_ref_risky_preg_cnt_fwa + "</td>"
                        + "<td>" + json[i].r_ref_eclampsia_mgso4_inj_refer_fwa + "</td>"
                        + "<td>" + json[i].r_ref_newborn_difficulty_fwa + "</td>"
                        + "<td>" + json[i].r_infertile_consultstatus + "</td>"
                        + "<td>" + json[i].r_infertile_referstatus + "</td>"
                        + "<td>" + json[i].r_tt_women_1st_fwa + "</td>"
                        + "<td>" + json[i].r_tt_women_2nd_fwa + "</td>"
                        + "<td>" + json[i].r_tt_women_3rd_fwa + "</td>"
                        + "<td>" + json[i].r_tt_women_4th_fwa + "</td>"
                        + "<td>" + json[i].r_tt_women_5th_fwa + "</td>"
                        + "<td>" + json[i].r_ecp_taken + "</td>"
                        + "<td>" + json[i].r_teen_counseling_adolescent_change_fwa + "</td>"
                        + "<td>" + json[i].r_teen_counseling_child_marriage_preg_effect_fwa + "</td>"
                        + "<td>" + json[i].r_teen_counseling_iron_folic_fwa + "</td>"
                        + "<td>" + json[i].r_teen_counseling_sexual_disease_fwa + "</td>"
                        + "<td>" + json[i].r_teen_counseling_healthy_balanced_diet_fwa + "</td>"
                        + "<td>" + json[i].r_teen_counseling_adolescence_violence_prevention_fwa + "</td>"
                        + "<td>" + json[i].r_teen_counseling_mental_prob_drug_addict_prevention_fwa + "</td>"
                        + "<td>" + json[i].r_teen_counseling_cleanliness_sanitary_pad_fwa + "</td>"
                        + "<td>" + json[i].r_teen_counseling_referred_fwa + "</td>"
                        + "<td>" + json[i].aaaaaaaaaaaaa + "</td>"
                        + "</tr>";
                $('#mis2Page4').append(Page4);

                var Page5 = "<tr>"
                        + "<td>" + $.getUnitName(json[i].r_unit, 1) + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_bcg_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_pentavalent_1_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_pentavalent_2_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_pentavalent_3_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_pcv1_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_pcv2_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_pcv3_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_bopv_1_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_bopv_2_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_bopv_3_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_ipv_1_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_ipv_2_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_mr_1_fwa + "</td>"
                        + "<td>" + json[i].r_vaccinated_child_0to15mnths_mr_2_fwa + "</td>"
                        + "<td>" + json[i].r_referred_child_dangerous_disease_fwa + "</td>"
                        + "<td>" + json[i].r_referred_child_neumonia_fwa + "</td>"
                        + "<td>" + json[i].r_referred_child_diahoea_fwa + "</td>"
                        + "<td>" + json[i].r_tot_live_birth_fwa + "</td>"
                        + "<td>" + json[i].r_less_weight_birth_less_then_2500g_fwa + "</td>"
                        + "<td>" + json[i].r_less_weight_birth_less_then_2000g_fwa + "</td>"
                        + "<td>" + json[i].r_immature_birth_fwa + "</td>"
                        + "<td>" + json[i].r_still_birth_fwa + "</td>"
                        + "<td>" + json[i].r_death_number_less_1yr_0to7days_fwa + "</td>"
                        + "<td>" + json[i].r_death_number_less_1yr_8to28days_fwa + "</td>"
                        + "<td>" + json[i].r_death_number_less_1yr_29dystoless1yr_fwa + "</td>"
                        + "<td>" + json[i].r_death_number_less_1yr_tot_fwa + "</td>"
                        + "<td>" + json[i].r_death_number_1yrto5yr_fwa + "</td>"
                        + "<td>" + json[i].r_death_number_maternal_death_fwa + "</td>"
                        + "<td>" + json[i].r_death_number_other_death_fwa + "</td>"
                        + "<td>" + json[i].r_death_number_all_death_fwa + "</td>"
                        + "</tr>";
                $('#mis2Page5').append(Page5);


                //Page 6
                var fpiFirstRow = "\n";
                if (j == 0) {
                    fpiFirstRow = "<td rowspan='10'>" + fpiData.fortnightly_meeting_fpi + "</td>"
                            + "<td rowspan='10'>" + fpiData.union_fp_committee_fpi + "</td>";
                }
                var Page6 = "<tr>"
                        + "<td>" + $.getUnitName(json[i].r_unit, 1) + "</td>"
                        + "<td>" + json[i].r_iron_folicacid_extrafood_counsiling_preg_woman + "</td>"
                        + "<td>" + json[i].r_iron_folicacid_extrafood_counsiling_child_0to23months + "</td>"
                        + "<td>" + json[i].r_iron_folicacid_distribute_preg_woman + "</td>"
                        + "<td>" + json[i].r_iron_folicacid_distribute_child_0to23months + "</td>"
                        + "<td>" + json[i].r_bfeeding_complementary_food_counsiling_preg_woman + "</td>"
                        + "<td>" + json[i].r_bfeeding_complementary_food_counsiling_child_0to23months + "</td>"
                        + "<td>" + json[i].r_mnp_ounsiling_child_0to23months + "</td>"
                        + "<td>" + json[i].r_birth_only_bfeed_0to6mon + "</td>"
                        + "<td>" + json[i].r_v0_59_child_complementary_food_6to23mon + "</td>"
                        + "<td>" + json[i].r_v0_59_child_complementary_food_24to59mon + "</td>"
                        + "<td>" + json[i].r_mnp_given_6to23mon + "</td>"
                        + "<td>" + json[i].r_mnp_given_24toless60mon + "</td>"
                        + "<td>" + json[i].r_mam_child_0to6mon + "</td>"
                        + "<td>" + json[i].r_mam_child_6to23mon + "</td>"
                        + "<td>" + json[i].r_mam_child_24to60mon + "</td>"
                        + "<td>" + json[i].r_sam_child_0to6mon + "</td>"
                        + "<td>" + json[i].r_sam_child_6to23mon + "</td>"
                        + "<td>" + json[i].r_sam_child_24toless60mon + "</td>"
                        + "<td>" + json[i].r_satelite_clinic_presence + "</td>"
                        + "<td>" + json[i].r_epi_session_presence + "</td>"
                        + "<td>" + json[i].r_community_clinic_presence + "</td>"
                        + "<td>" + json[i].r_yard_meeting_presence + "</td>"
                        + "<td>" + fpiData.nsv_inspired_fpi + "</td>"
                        + "<td>" + fpiData.av_van_display_fpi + "</td>"
                        + "<td>" + fpiData.elco_day_count_fpi + "</td>"
                        + "<td>" + fpiData.no_of_elco_count_fpi + "</td>"
                        + "<td>" + fpiData.fwa_register_fpi + "</td>"
                        + "<td>" + fpiData.yard_meeting_fpi + "</td>"
                        + "" + fpiFirstRow + ""
                        + "<td>" + fpiData.satellite_clinic_presence_fpi + "</td>"
                        + "</tr>";
                $('#mis2Page6').append(Page6);

                var Page7 = "<tr>"
                        + "<td>" + $.getUnitName(json[i].r_unit, 1) + "</td>"
                        + "<td>" + json[i].r_preg_anc_service_visit1_csba + "</td>"
                        + "<td>" + json[i].r_preg_anc_service_visit2_csba + "</td>"
                        + "<td>" + json[i].r_preg_anc_service_visit3_csba + "</td>"
                        + "<td>" + json[i].r_preg_anc_service_visit4_csba + "</td>"
                        + "<td>" + json[i].r_preg_anc_counselling_after_delivery_csba + "</td>"
                        + "<td>" + json[i].r_preg_anc_misoprostol_supplied_csba + "</td>"
                        + "<td>" + json[i].r_preg_anc_chlorohexidin_supplied_csba + "</td>"
                        + "<td>" + json[i].r_delivary_service_delivery_done_csba + "</td>"
                        + "<td>" + json[i].r_delivary_service_3rd_amtsl_csba + "</td>"
                        + "<td>" + json[i].r_delivary_service_misoprostol_taken_csba + "</td>"
                        + "<td>" + json[i].r_pnc_mother_visit1_csba + "</td>"
                        + "<td>" + json[i].r_pnc_mother_visit2_csba + "</td>"
                        + "<td>" + json[i].r_pnc_mother_visit3_csba + "</td>"
                        + "<td>" + json[i].r_pnc_mother_visit4_csba + "</td>"
                        + "<td>" + json[i].r_pnc_mother_home_delivery_training_csba + "</td>"
                        + "<td>" + json[i].r_pnc_mother_family_planning_counselling_csba + "</td>"
                        + "<td>" + json[i].r_newborn_1min_washed_csba + "</td>"
                        + "<td>" + json[i].r_newborn_71_chlorohexidin_used_csba + "</td>"
                        + "<td>" + json[i].r_newborn_with_mother_skin_csba + "</td>"
                        + "<td>" + json[i].r_newborn_1hr_bfeeded_csba + "</td>"
                        + "<td>" + json[i].r_newborn_diff_breathing_resassite_csba + "</td>"
                        + "<td>" + json[i].r_pnc_newborn_visit1_csba + "</td>"
                        + "<td>" + json[i].r_pnc_newborn_visit2_csba + "</td>"
                        + "<td>" + json[i].r_pnc_newborn_visit3_csba + "</td>"
                        + "<td>" + json[i].r_pnc_newborn_visit4_csba + "</td>"
                        + "<td>" + json[i].r_ref_risky_preg_cnt_csba + "</td>"
                        + "<td>" + json[i].r_ref_eclampsia_mgso4_inj_refer_csba + "</td>"
                        + "<td>" + json[i].r_ref_newborn_difficulty_csba + "</td>"
                        + "<td>" + json[i].r_tot_live_birth_csba + "</td>"
                        + "<td>" + json[i].r_immature_birth_csba + "</td>"
                        + "<td>" + json[i].r_still_birth_csba + "</td>"
                        + "</tr>";
                $('#mis2Page7').append(Page7);
                if (lmis.length == 0) {
                    $("#mis2Page8").append("<tr class='submitted'>\n" + mis2.renderRow(mis2.pageLength[8], '&nbsp;', providers[j].fwaunit, providers[j].provname) + "</tr>")
                    $("#mis2Page9").append("<tr class='submitted'>\n" + mis2.renderRow(mis2.pageLength[9], '&nbsp;', providers[j].fwaunit, "") + "</tr>");
                    $("#mis2Page10").append("<tr class='submitted'>\n" + mis2.renderRow(mis2.pageLength[10], '&nbsp;', providers[j].fwaunit, "") + "</tr>");
//                
//                                    $("#mis2Page9").append("<tr class='submitted'>\n" + mis2.renderRow(mis2.pageLength[9], '&nbsp;', $.getUnitName(json[i].r_unit, 1), "") + "</tr>");
//                                    $("#mis2Page10").append("<tr class='submitted'>\n" + mis2.renderRow(mis2.pageLength[10], '&nbsp;', $.getUnitName(json[i].r_unit, 1), "") + "</tr>");
                }
            }

            //LMIS Data rendering
            if (lmis.length !== 0) {
                if (providers[j].fwaunit === lmis[i].unit) {
                    var Page8 = "<tr>"
                            + "<td>" + $.getUnitName(lmis[i].unit, 1) + "</td>"
                            + "<td colspan='10'>" + providers[j].provname + "</td>"
                            + "<td>" + lmis[i].openingbalance_sukhi + "</td>"
                            + "<td>" + lmis[i].receiveqty_sukhi + "</td>"
                            + "<td>" + lmis[i].current_month_stock_sukhi + "</td>"
                            + "<td>" + lmis[i].adjustment_plus_sukhi + "</td>"
                            + "<td>" + lmis[i].adjustment_minus_sukhi + "</td>"
                            + "<td>" + lmis[i].total_sukhi + "</td>"
                            + "<td>" + lmis[i].distribution_sukhi + "</td>"
                            + "<td>" + lmis[i].closingbalance_sukhi + "</td>"
                            + "<td>" + mis2.stockvacuum[lmis[i].stockvacuum_sukhi] + "</td>"
                            + "<td>" + lmis[i].openingbalance_apon + "</td>"
                            + "<td>" + lmis[i].receiveqty_apon + "</td>"
                            + "<td>" + lmis[i].current_month_stock_apon + "</td>"
                            + "<td>" + lmis[i].adjustment_plus_apon + "</td>"
                            + "<td>" + lmis[i].adjustment_minus_apon + "</td>"
                            + "<td>" + lmis[i].total_apon + "</td>"
                            + "<td>" + lmis[i].distribution_apon + "</td>"
                            + "<td>" + lmis[i].closingbalance_apon + "</td>"
                            + "<td>" + mis2.stockvacuum[lmis[i].stockvacuum_apon] + "</td>"
                            + "<td>" + lmis[i].openingbalance_condom + "</td>"
                            + "<td>" + lmis[i].receiveqty_condom + "</td>"
                            + "<td>" + lmis[i].current_month_stock_condom + "</td>"
                            + "<td>" + lmis[i].adjustment_plus_condom + "</td>"
                            + "<td>" + lmis[i].adjustment_minus_condom + "</td>"
                            + "<td>" + lmis[i].total_condom + "</td>"
                            + "<td>" + lmis[i].distribution_condom + "</td>"
                            + "<td>" + lmis[i].closingbalance_condom + "</td>"
                            + "<td>" + mis2.stockvacuum[lmis[i].stockvacuum_condom] + "</td>"
                            + "</tr>";
                    $('#mis2Page8').append(Page8);

                    var Page9 = "<tr>"
                            + "<td>" + $.getUnitName(lmis[i].unit, 1) + "</td>"
                            + "<td>" + lmis[i].openingbalance_inject_vayal + "</td>"
                            + "<td>" + lmis[i].receiveqty_inject_vayal + "</td>"
                            + "<td>" + lmis[i].current_month_stock_inject_vayal + "</td>"
                            + "<td>" + lmis[i].adjustment_plus_inject_vayal + "</td>"
                            + "<td>" + lmis[i].adjustment_minus_inject_vayal + "</td>"
                            + "<td>" + lmis[i].total_inject_vayal + "</td>"
                            + "<td>" + lmis[i].distribution_inject_vayal + "</td>"
                            + "<td>" + lmis[i].closingbalance_inject_vayal + "</td>"
                            + "<td>" + mis2.stockvacuum[lmis[i].stockvacuum_inject_vayal] + "</td>"
                            + "<td>" + lmis[i].openingbalance_inject_syringe + "</td>"
                            + "<td>" + lmis[i].receiveqty_inject_syringe + "</td>"
                            + "<td>" + lmis[i].current_month_stock_inject_syringe + "</td>"
                            + "<td>" + lmis[i].adjustment_plus_inject_syringe + "</td>"
                            + "<td>" + lmis[i].adjustment_minus_inject_syringe + "</td>"
                            + "<td>" + lmis[i].total_inject_syringe + "</td>"
                            + "<td>" + lmis[i].distribution_inject_syringe + "</td>"
                            + "<td>" + lmis[i].closingbalance_inject_syringe + "</td>"
                            + "<td>" + mis2.stockvacuum[lmis[i].stockvacuum_inject_syringe] + "</td>"
                            + "<td>" + lmis[i].openingbalance_ecp + "</td>"
                            + "<td>" + lmis[i].receiveqty_ecp + "</td>"
                            + "<td>" + lmis[i].current_month_stock_ecp + "</td>"
                            + "<td>" + lmis[i].adjustment_plus_ecp + "</td>"
                            + "<td>" + lmis[i].adjustment_minus_ecp + "</td>"
                            + "<td>" + lmis[i].total_ecp + "</td>"
                            + "<td>" + lmis[i].distribution_ecp + "</td>"
                            + "<td>" + lmis[i].closingbalance_ecp + "</td>"
                            + "<td>" + mis2.stockvacuum[lmis[i].stockvacuum_ecp] + "</td>"
                            + "<td>" + lmis[i].openingbalance_misoprostol + "</td>"
                            + "<td>" + lmis[i].receiveqty_misoprostol + "</td>"
                            + "<td>" + lmis[i].current_month_stock_misoprostol + "</td>"
                            + "<td>" + lmis[i].adjustment_plus_misoprostol + "</td>"
                            + "<td>" + lmis[i].adjustment_minus_misoprostol + "</td>"
                            + "<td>" + lmis[i].total_misoprostol + "</td>"
                            + "<td>" + lmis[i].distribution_misoprostol + "</td>"
                            + "<td>" + lmis[i].closingbalance_misoprostol + "</td>"
                            + "<td>" + mis2.stockvacuum[lmis[i].stockvacuum_misoprostol] + "</td>"
                            + "</tr>";
                    $('#mis2Page9').append(Page9);

                    var Page10 = "<tr>"
                            + "<td>" + $.getUnitName(lmis[i].unit, 1) + "</td>"
                            + "<td>" + lmis[i].openingbalance_chlorhexidine + "</td>"
                            + "<td>" + lmis[i].receiveqty_chlorhexidine + "</td>"
                            + "<td>" + lmis[i].current_month_stock_chlorhexidine + "</td>"
                            + "<td>" + lmis[i].adjustment_plus_chlorhexidine + "</td>"
                            + "<td>" + lmis[i].adjustment_minus_chlorhexidine + "</td>"
                            + "<td>" + lmis[i].total_chlorhexidine + "</td>"
                            + "<td>" + lmis[i].distribution_chlorhexidine + "</td>"
                            + "<td>" + lmis[i].closingbalance_chlorhexidine + "</td>"
                            + "<td>" + mis2.stockvacuum[lmis[i].stockvacuum_chlorhexidine] + "</td>"
                            + "<td>" + lmis[i].openingbalance_mnp + "</td>"
                            + "<td>" + lmis[i].receiveqty_mnp + "</td>"
                            + "<td>" + lmis[i].current_month_stock_mnp + "</td>"
                            + "<td>" + lmis[i].adjustment_plus_mnp + "</td>"
                            + "<td>" + lmis[i].adjustment_minus_mnp + "</td>"
                            + "<td>" + lmis[i].total_mnp + "</td>"
                            + "<td>" + lmis[i].distribution_mnp + "</td>"
                            + "<td>" + lmis[i].closingbalance_mnp + "</td>"
                            + "<td>" + mis2.stockvacuum[lmis[i].stockvacuum_mnp] + "</td>"
                            + "<td>" + lmis[i].openingbalance_iron + "</td>"
                            + "<td>" + lmis[i].receiveqty_iron + "</td>"
                            + "<td>" + lmis[i].current_month_stock_iron + "</td>"
                            + "<td>" + lmis[i].adjustment_plus_iron + "</td>"
                            + "<td>" + lmis[i].adjustment_minus_iron + "</td>"
                            + "<td>" + lmis[i].total_iron + "</td>"
                            + "<td>" + lmis[i].distribution_iron + "</td>"
                            + "<td>" + lmis[i].closingbalance_iron + "</td>"
                            + "<td>" + mis2.stockvacuum[lmis[i].stockvacuum_iron] + "</td>"
                            + "</tr>";
                    $('#mis2Page10').append(Page10);
                }
            }
        }

        //make unsubmitted MIS2 row.
        if (!isSubmitted) {
            for (var i = 1; i < 11; i++) {
                if (i == 6) {
                    $(mis2.page[i]).append("<tr class='not-submitted'>\n" + mis2.renderFPIRow(mis2.pageLength[i], '&nbsp;', providers[j].fwaunit, j, fpiIndex) + "</tr>");
                } else {
                    i == 8 ? $(mis2.page[i]).append("<tr class='not-submitted'>\n" + mis2.renderRow(mis2.pageLength[i], '&nbsp;', providers[j].fwaunit, providers[j].provname) + "</tr>") : $(mis2.page[i]).append("<tr class='not-submitted'>\n" + mis2.renderRow(mis2.pageLength[i], '&nbsp;', providers[j].fwaunit, "") + "</tr>");
                }

            }
        }
    }
    //Load sorbomot
//                        $(mis2.page[1]).append("<tr>\n" + getLastRow(cal, 1, car) + "</tr>");                        
    for (var i = 1; i < 11; i++) {
        if (i >= 8)
            cal = new Calc(lmis);
        $(mis2.page[i]).append("<tr>\n" + getLastRow(cal, i, car) + "</tr>");
    }
    //Replace undefine keyword
    $.each(mis2.page, function (index, val) {
        $('table').find(val).find('tr').find('td').text(function () {
            if ($(this).text() == "undefined" || $(this).text() == "null" || $(this).text() == "0" || $(this).text() == "০") {
                return "-"
            } else {
                if ($.isNumeric($(this).text())) {
                    return e2b($(this).text());
                }
            }
        });
    });
};

