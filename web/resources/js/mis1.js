//$(function () {
var obj = {
    1: ["openingbalance"],
    2: ["receiveqty"],
    3: ["current_month_stock"],
    4: ["adjustment_plus"],
    5: ["adjustment_minus"],
    6: ["total"],
    7: ["distribution"],
    8: ["closingbalance"]
};
var item = {
    1: ["sukhi", "1"],
    2: ["apon", "10"],
    3: ["condom", "2"],
    4: ["inject_vayal", "3"],
    5: ["inject_syringe", "5"],
    6: ["ecp", "4"],
    7: ["misoprostol", "9"],
    8: ["mnp", "20"],
    9: ["iron", "19"]
};

//$.each([ 52, 97 ], function( index, value ) {
//  alert( index + ": " + value );
//});

function clearLMIS() {
    $.each(item, function(i, o) {
        $.each(obj, function(index, object) {
            $('#' + object + "" + o[1]).text("");
        });
    });
}

function a() {
    $.each(item, function(i, o) {
        $.each(obj, function(index, object) {
            $('#' + object + "" + o[1]).text("1");
        });
    });
}

function makeLMISJson() {
    var masterJson = {};
    $.each(item, function(i, o) {
        $.each(obj, function(index, object) {
            var key =  object + "" + o[1];
            var value = b2e($('#' + object + "" + o[1]).text());
            var tempJson = {};
            tempJson[key] = value;
            $.extend( masterJson, tempJson );
        });
    });
    return masterJson;
}

function mJson() {
    var masterJson = {};
    $.each(item, function(i, o) {
        $.each(obj, function(index, object) {
            var key =  object + "" + o[1];
            var value = b2e($('#' + object + "" + o[1]).text());
            var tempJson = {};
            tempJson[key] = value;
            $.extend( masterJson, tempJson );
        });
    });
    return masterJson;
}

//});

function clearData() {
//    
//            $("#unitValue").val("..........................");
//            $("#wardValue").val("..........................");
//            $("#unionValue").val("..........................");
//            $("#upazilaValue").val("..........................");
//            $("#districtValue").val("..........................");
//            $("#yearValue").val("..........................");
//            $("#monthValue").val("..........................");


    //=========================================== Begin (Ka) Family Planing method ==================================================



    //-------------------Row-No-one-1  colum-No-one-1     ( old - Puraton )------------------------------------ 
    $("#r_old_pill").empty();
    $("#r_old_condom").empty();
    $("#r_old_inject").empty();
    $("#r_old_iud").empty();
    $("#r_old_implant").empty();
    $("#r_old_permanent_man").empty();
    $("#r_old_permanent_woman").empty(); //(json[0].r_old_permanent_woman);
    $("#r_old_all_total").empty(); //(json[0].r_old_all_total);

    //-------------------Row-No-one-1  colum-No-two-2     ( new - noton )--------------------------------------
    $("#r_new_pill").empty(); //(json[0].r_new_pill);
    $("#r_new_condom").empty(); //(json[0].r_new_condom);
    $("#r_new_inject").empty(); //(json[0].r_new_inject);
    $("#r_new_iud").empty(); //(json[0].r_new_iud);
    $("#r_new_implant").empty(); //(json[0].r_new_implant);
    $("#r_new_permanent_man").empty(); //(json[0].r_new_permanent_man);
    $("#r_new_permanent_woman").empty(); //(json[0].r_new_permanent_woman);
    $("#r_new_all_total").empty(); //(json[0].r_new_all_total);

    //-------------------Row-No-one-1  colum-No-three-3     ( current_month - Cholti_maser)------------------------------------
    $("#r_curr_month_pill_total").empty(); //(json[0].r_curr_month_pill_total);
    $("#r_curr_month_condom_total").empty(); //(json[0].r_curr_month_condom_total);
    $("#r_curr_month_inject_total").empty(); //(json[0].r_curr_month_inject_total);
    $("#r_curr_month_iud_total").empty(); //(json[0].r_curr_month_iud_total);
    $("#r_curr_month_implant_total").empty(); //(json[0].r_curr_month_implant_total);
    $("#r_curr_month_permanent_man").empty(); //(json[0].r_curr_month_permanent_man);
    $("#r_curr_month_permanent_woman").empty(); //(json[0].r_curr_month_permanent_woman);
    $("#r_curr_month_all_total").empty(); //(json[0].r_curr_month_all_total);

    //-------------------Row-No-one-1  colum-No-four-4     ( Previous_month - purboborti_maser mot)-------------------------------------
//        if(json[0].r_priv_month_pill_total==='null')json[0].r_priv_month_pill_total=0;
//        if(json[0].r_priv_month_condom_total==='null')json[0].r_priv_month_condom_total=0;
//        if(json[0].r_priv_month_inject_total==='null')json[0].r_priv_month_inject_total=0;
//        if(json[0].r_priv_month_iud_total==='null')json[0].r_priv_month_iud_total=0;
//        if(json[0].r_priv_month_implant_total==='null')json[0].r_priv_month_implant_total=0;
//        if(json[0].r_priv_month_permanent_man==='null')json[0].r_priv_month_permanent_man=0;
//        if(json[0].r_priv_month_permanent_woman==='null')json[0].r_priv_month_permanent_woman=0;
//        if(json[0].r_priv_month_all_total==='null')json[0].r_priv_month_all_total=0;
//
//        //Calculate Total
//        json[0].r_priv_month_all_total=((json[0].r_priv_month_pill_total) + (json[0].r_priv_month_condom_total)  + (json[0].r_priv_month_inject_total) + (json[0].r_priv_month_iud_total) + (json[0].r_priv_month_implant_total) + (json[0].r_priv_month_permanent_man) + (json[0].r_priv_month_permanent_woman)) ;

    $("#r_priv_month_pill_total").empty(); //(json[0].r_priv_month_pill_total);
    $("#r_priv_month_condom_total").empty(); //(json[0].r_priv_month_condom_total);
    $("#r_priv_month_inject_total").empty(); //(json[0].r_priv_month_inject_total);
    $("#r_priv_month_iud_total").empty(); //(json[0].r_priv_month_iud_total);
    $("#r_priv_month_implant_total").empty(); //(json[0].r_priv_month_implant_total);
    $("#r_priv_month_permanent_man").empty(); //(json[0].r_priv_month_permanent_man);
    $("#r_priv_month_permanent_woman").empty(); //(json[0].r_priv_month_permanent_woman);



    $("#r_priv_month_all_total").empty(); //(json[0].r_priv_month_all_total);



    //-------------------Row-No-one-1  colum-No-five-5     ( Unit_total - Uniter_sorbomot )--------------------------------------
//        if(json[0].r_unit_pill_tot==='null' || json[0].r_unit_pill_tot===0) json[0].r_unit_pill_tot=((json[0].r_curr_month_pill_total)+(json[0].r_priv_month_pill_total));
//
//        if(json[0].r_unit_condom_tot==='null'  || json[0].r_unit_condom_tot===0) json[0].r_unit_condom_tot=((json[0].r_curr_month_condom_total)+(json[0].r_priv_month_condom_total));
//
//        if(json[0].r_unit_inject_tot==='null' || json[0].r_unit_inject_tot===0) json[0].r_unit_inject_tot=((json[0].r_curr_month_inject_total)+(json[0].r_priv_month_inject_total));
//
//        if(json[0].r_unit_iud_tot==='null' || json[0].r_unit_iud_tot===0) json[0].r_unit_iud_tot=((json[0].r_curr_month_iud_total)+(json[0].r_priv_month_iud_total));
//
//        if(json[0].r_unit_implant_tot==='null' || json[0].r_unit_implant_tot===0) json[0].r_unit_implant_tot=((json[0].r_curr_month_implant_total)+(json[0].r_priv_month_implant_total));
//
//        if(json[0].r_unit_permanent_man_tot==='null' || json[0].r_unit_permanent_man_tot===0) json[0].r_unit_permanent_man_tot=((json[0].r_curr_month_permanent_man)+(json[0].r_priv_month_permanent_man));
//
//        if(json[0].r_unit_permanent_woman_tot==='null' || json[0].r_unit_permanent_woman_tot===0) json[0].r_unit_permanent_woman_tot=((json[0].r_curr_month_permanent_woman)+(json[0].r_priv_month_permanent_woman));
//
//        if(json[0].r_unit_all_total_tot==='null' || json[0].r_unit_all_total_tot===0) json[0].r_unit_all_total_tot=((json[0].r_curr_month_all_total)+(json[0].r_priv_month_all_total));

    $("#r_unit_pill_tot").empty(); //(json[0].r_unit_pill_tot);
    $("#r_unit_condom_tot").empty(); //(json[0].r_unit_condom_tot);
    $("#r_unit_inject_tot").empty(); //(json[0].r_unit_inject_tot);
    $("#r_unit_iud_tot").empty(); //(json[0].r_unit_iud_tot);
    $("#r_unit_implant_tot").empty(); //(json[0].r_unit_implant_tot);
    $("#r_unit_permanent_man_tot").empty(); //(json[0].r_unit_permanent_man_tot);
    $("#r_unit_permanent_woman_tot").empty(); //(json[0].r_unit_permanent_woman_tot);
    $("#r_unit_all_total_tot").empty(); //(json[0].r_unit_all_total_tot);

    //-------------------Row-No-one-1  colum-No-six-6     ( current_month_left_no_method - choltimase_chere_diyese_kono_podhoti_Neini )---------------------------------------
    $("#r_curr_m_left_pill_no_method").empty(); //(json[0].r_curr_m_left_pill_no_method);
    $("#r_curr_m_left_condom_no_method").empty(); //(json[0].r_curr_m_left_condom_no_method);
    $("#r_curr_m_left_inj_no_method").empty(); //(json[0].r_curr_m_left_inj_no_method);
    $("#r_curr_m_left_iud_no_method").empty(); //(json[0].r_curr_m_left_iud_no_method);
    $("#r_curr_m_left_implant_no_method").empty(); //(json[0].r_curr_m_left_implant_no_method);
    //                        $("#r_curr_m_left_per_man_no_method").empty(); //(json[0].r_curr_m_left_per_man_no_method);
    //                        $("#r_curr_m_left_per_woman_no_method").empty(); //(json[0].r_curr_m_left_per_woman_no_method);
    $("#r_curr_m_left_no_method_all_tot").empty(); //(json[0].r_curr_m_left_no_method_all_tot);

    //-------------------Row-No-one-1  colum-No-seven-7     ( current_month_left_other_method - choltimase_chere_diyese_ommo_podhoti_Neyeche )----------------------------------
    $("#r_curr_m_left_pill_oth_method").empty(); //(json[0].r_curr_m_left_pill_oth_method);
    $("#r_curr_m_left_condom_oth_method").empty(); //(json[0].r_curr_m_left_condom_oth_method);
    $("#r_curr_m_left_inj_oth_method").empty(); //(json[0].r_curr_m_left_inj_oth_method);
    $("#r_curr_m_left_iud_oth_method").empty(); //(json[0].r_curr_m_left_iud_oth_method);
    $("#r_curr_m_left_implant_oth_method").empty(); //(json[0].r_curr_m_left_implant_oth_method);
    //                        $("#r_curr_m_left_per_man_oth_method").empty(); //(json[0].r_curr_m_left_per_man_oth_method);
    //                        $("#r_curr_m_left_per_woman_oth_mthd").empty(); //(json[0].r_curr_m_left_per_woman_oth_mthd);
    $("#r_curr_m_left_oth_method_all_tot").empty(); //(json[0].r_curr_m_left_oth_method_all_tot);

    //-------------------Row-No-one-1  colum-No-eight-8     ( sent_for_method - podhotir_jonno_preron )----------------------------------
    //                        $("#r_sent_method_pill").empty(); //(json[0].r_sent_method_pill);
    //                        $("#r_sent_method_condom").empty(); //(json[0].r_sent_method_condom);
    $("#r_sent_method_inj").empty(); //(json[0].r_sent_method_inj);
    $("#r_sent_method_iud").empty(); //(json[0].r_sent_method_iud);
    $("#r_sent_method_implant").empty(); //(json[0].r_sent_method_implant);
    $("#r_sent_method_per_man").empty(); //(json[0].r_sent_method_per_man);
    $("#r_sent_method_per_woman").empty(); //(json[0].r_sent_method_per_woman);
    $("#r_sent_method_all_tot").empty(); //(json[0].r_sent_method_all_tot);

//        //-------------------Row-No-one-1  colum-No-nine-9     ( sent_side_effect )------------------------------------
//        if(json[0].r_sent_side_effect_condoms==='null' || json[0].r_sent_side_effect_condoms==='')json[0].r_sent_side_effect_condoms=0;

    $("#r_sent_side_effect_pill").empty(); //(json[0].r_sent_side_effect_pill);
    $("#r_sent_side_effect_condoms").empty(); //(json[0].r_sent_side_effect_condoms);
    $("#r_sent_side_effect_inj").empty(); //(json[0].r_sent_side_effect_inj);
    $("#r_sent_side_effect_iud").empty(); //(json[0].r_sent_side_effect_iud);
    $("#r_sent_side_effect_implant").empty(); //(json[0].r_sent_side_effect_implant);
    $("#r_sent_side_effect_per_man").empty(); //(json[0].r_sent_side_effect_per_man);
    $("#r_sent_side_effect_per_woman").empty(); //(json[0].r_sent_side_effect_per_woman);
    $("#r_sent_side_effect_all_tot").empty(); //(json[0].r_sent_side_effect_all_tot);

    //----------------------------------------------------Bottom Part-----------------------------------------------------
    $("#r_curr_m_shown_capable_elco_tot").empty(); //(json[0].r_curr_m_shown_capable_elco_tot);
    $("#r_priv_m_shown_capable_elco_tot").empty(); //(json[0].r_priv_m_shown_capable_elco_tot);
    $("#r_unit_capable_elco_tot").empty(); //(json[0].r_unit_capable_elco_tot);
    $("#r_curr_m_v_new_elco_tot").empty(); //(json[0].r_curr_m_v_new_elco_tot);
//
//        var car = Number(((json[0].r_unit_all_total_tot / json[0].r_unit_capable_elco_tot) * 100).toFixed(2));
    $("#r_car").empty(); //(car + "%");

    //=========================================== END (Ka) Family Planing method ==================================================

    $("#curr_month_preg_old_fwa").empty(); //(json[0].r_curr_month_preg_old_fwa);
    $("#curr_month_preg_new_fwa").empty(); //(json[0].r_curr_month_preg_new_fwa);
    $("#curr_month_preg_tot_fwa").empty(); //(json[0].r_curr_month_preg_tot_fwa);

    $("#prir_month_tot_preg_fwa").empty(); //(json[0].r_prir_month_tot_preg_fwa);
    $("#unit_tot_preg_fwa").empty(); //(json[0].r_unit_tot_preg_fwa);

    $("#preg_anc_service_visit1_fwa").empty(); //(json[0].r_preg_anc_service_visit1_fwa);
    $("#preg_anc_service_visit1_csba").empty(); //(json[0].r_preg_anc_service_visit1_csba);

    $("#preg_anc_service_visit2_fwa").empty(); //(json[0].r_preg_anc_service_visit2_fwa);
    $("#preg_anc_service_visit2_csba").empty(); //(json[0].r_preg_anc_service_visit2_csba);

    $("#preg_anc_service_visit3_fwa").empty(); //(json[0].r_preg_anc_service_visit3_fwa);
    $("#preg_anc_service_visit3_csba").empty(); //(json[0].r_preg_anc_service_visit3_csba);

    $("#preg_anc_service_visit4_fwa").empty(); //(json[0].r_preg_anc_service_visit4_fwa);
    $("#preg_anc_service_visit4_csba").empty(); //(json[0].r_preg_anc_service_visit4_csba);


    $("#delivary_service_home_trained_fwa").empty(); //(json[0].r_delivary_service_home_trained_fwa);
    $("#delivary_service_home_untrained_fwa").empty(); //(json[0].r_delivary_service_home_untrained_fwa);

    $("#delivary_service_hospital_normal_fwa").empty(); //(json[0].r_delivary_service_hospital_normal_fwa);
    $("#delivary_service_hospital_operation_fwa").empty(); //(json[0].r_delivary_service_hospital_operation_fwa);

    $("#delivary_service_delivery_done_csba").empty(); //(json[0].r_delivary_service_delivery_done_csba);
    $("#delivary_service_3rd_amts1_csba").empty(); //(json[0].r_delivary_service_3rd_amts1_csba);
    $("#delivary_service_misoprostol_taken_csba").empty(); //(json[0].r_delivary_service_misoprostol_taken_csba);


    $("#pnc_mother_visit1_fwa").empty(); //(json[0].r_pnc_mother_visit1_fwa);
    $("#pnc_mother_visit1_csba").empty(); //(json[0].r_pnc_mother_visit1_csba);

    $("#pnc_mother_visit2_fwa").empty(); //(json[0].r_pnc_mother_visit2_fwa);
    $("#pnc_mother_visit2_csba").empty(); //(json[0].r_pnc_mother_visit2_csba);

    $("#pnc_mother_visit3_fwa").empty(); //(json[0].r_pnc_mother_visit3_fwa);
    $("#pnc_mother_visit3_csba").empty(); //(json[0].r_pnc_mother_visit3_csba);

    $("#pnc_mother_visit4_fwa").empty(); //(json[0].r_pnc_mother_visit4_fwa);
    $("#pnc_mother_visit4_csba").empty(); //(json[0].r_pnc_mother_visit4_csba);

    $("#pnc_mother_family_planning_csba").empty(); //(json[0].r_pnc_mother_family_planning_csba);


    $("#pnc_child_visit1_fwa").empty(); //(json[0].r_pnc_mother_visit1_fwa);
    $("#pnc_child_visit1_csba").empty(); //(json[0].r_pnc_mother_visit1_csba);

    $("#pnc_child_visit2_fwa").empty(); //(json[0].r_pnc_mother_visit2_fwa);
    $("#pnc_child_visit2_csba").empty(); //(json[0].r_pnc_mother_visit2_csba);

    $("#pnc_child_visit3_fwa").empty(); //(json[0].r_pnc_mother_visit3_fwa);
    $("#pnc_child_visit3_csba").empty(); //(json[0].r_pnc_mother_visit3_csba);

    $("#pnc_child_visit4_fwa").empty(); //(json[0].r_pnc_mother_visit4_fwa);
    $("#pnc_child_visit4_csba").empty(); //(json[0].r_pnc_mother_visit4_csba);

    $("#ref_risky_preg_cnt_fwa").empty(); //(json[0].v_ref_risky_preg_cnt_fwa);


    $("#ref_preg_delivery_pnc_diff_refer_csba").empty(); //(json[0].v_ref_preg_delivery_pnc_diff_refer_csba);
    $("#ref_eclampsia_mgso4_inj_refer_csba").empty(); //(json[0].v_ref_eclampsia_mgso4_inj_refer_csba);
    $("#ref_newborn_difficulty_csba").empty(); //(json[0].v_ref_newborn_difficulty_csba);

    $("#tt_women_1st_fwa").empty(); //(json[0].r_tt_women_1st_fwa);
    $("#tt_women_2nd_fwa").empty(); //(json[0].r_tt_women_2nd_fwa);
    $("#tt_women_3rd_fwa").empty(); //(json[0].r_tt_women_3rd_fwa);
    $("#tt_women_4th_fwa").empty(); //(json[0].r_tt_women_4th_fwa);
    $("#tt_women_5th_fwa").empty(); //(json[0].r_tt_women_5th_fwa);


    $("#ecp_taken").empty(); //(json[0].r_ecp_taken);
    $("#misoprostol_taken").empty(); //(json[0].r_misoprostol_taken);

    $("#childless_couple_adviced_fwa").empty(); //(json[0].v_childless_couple_adviced_fwa);
    $("#childless_couple_refered_fwa").empty(); //(json[0].v_childless_couple_refered_fwa);

    $("#teenager_counsiling_referred").empty(); //(json[0].r_teenager_counsiling_referred);
    $("#teenager_counsiling_child_marriage_child_preg_disadvantage").empty(); //(json[0].r_teenager_counsiling_child_marriage_child_preg_disadvantage);

    $("#teenager_counsiling_healthy_balanced_diet").empty(); //(json[0].r_teenager_counsiling_healthy_balanced_diet);
    $("#teenager_counsiling_sexual_disease").empty(); //(json[0].r_teenager_counsiling_sexual_disease);

    $("#satelite_clinic_presence").empty(); //(json[0].r_satelite_clinic_presence);
    $("#epi_session_presence").empty(); //(json[0].r_epi_session_presence);
    $("#community_clinic_presence").empty(); //(json[0].r_community_clinic_presence);


    $("#newborn_1min_washed_fwa").empty(); //(json[0].r_newborn_1min_washed_fwa);
    $("#newborn_1min_washed_csba").empty(); //(json[0].r_newborn_1min_washed_csba);

    $("#newborn_71_chlorohexidin_used_fwa").empty(); //(json[0].r_newborn_71_chlorohexidin_used_fwa);
    $("#newborn_71_chlorohexidin_used_csba").empty(); //(json[0].r_newborn_71_chlorohexidin_used_csba);

    $("#newborn_1hr_bfeeded_csba").empty(); //(json[0].r_newborn_1hr_bfeeded_csba);
    //                        $("#newborn_1hr_bfeeded_fwa").empty(); //(json[0].r_newborn_1hr_bfeeded_fwa);

    $("#newborn_diff_breathing_resassite_csba").empty(); //(json[0].r_newborn_diff_breathing_resassite_csba);


    $("#vaccinated_child_bcg_fwa").empty(); //(json[0].r_vaccinated_child_bcg_fwa);

    $("#vaccinated_0t01yrs_child_pcv_pentavalent_1_fwa").empty(); //(json[0].r_vaccinated_0t01yrs_child_pcv_pentavalent_1_fwa);
    $("#vaccinated_0t01yrs_child_pcv_pentavalent_2_fwa").empty(); //(json[0].r_vaccinated_0t01yrs_child_pcv_pentavalent_2_fwa);
    $("#vaccinated_0t01yrs_child_pcv_pentavalent_3_fwa").empty(); //(json[0].r_vaccinated_0t01yrs_child_pcv_pentavalent_3_fwa);
    $("#vaccinated_0t01yrs_child_pcv_pentavalent_4_fwa").empty(); //(json[0].r_vaccinated_0t01yrs_child_pcv_pentavalent_4_fwa);

    $("#vaccinated_0t01yrs_child_opv3_fwa").empty(); //(json[0].r_vaccinated_0t01yrs_child_opv3_fwa);
    $("#vaccinated_child_ham_fwa").empty(); //(json[0].r_vaccinated_child_ham_fwa);

    $("#referred_child_dangerous_disease_fwa").empty(); //(json[0].r_referred_child_dangerous_disease_fwa);
    $("#referred_child_neumonia_fwa").empty(); //(json[0].r_referred_child_neumonia_fwa);
    $("#referred_child_diahoea_fwa").empty(); //(json[0].r_referred_child_diahoea_fwa);



    $("#tot_live_birth_fwa").empty(); //(json[0].r_tot_live_birth_fwa);
    //                        $("#tot_live_birth_csba").empty(); //(json[0].r_tot_live_birth_csba);


    $("#less_weight_birth_fwa").empty(); //(json[0].r_less_weight_birth_fwa);
    //                        $("#less_weight_birth_csba").empty(); //(json[0].r_less_weight_birth_csba);

    $("#immature_birth_fwa").empty(); //(json[0].r_immature_birth_fwa);
    //                        $("#immature_birth_csba").empty(); //(json[0].r_immature_birth_csba);

    $("#death_birth_fwa").empty(); //(json[0].r_death_birth_fwa);
    //                        $("#death_birth_csba").empty(); //(json[0].r_death_birth_csba);

    $("#death_number_less_1yr_0to7days_fwa").empty(); //(json[0].r_death_number_less_1yr_0to7days_fwa);
    //                        $("#death_number_less_1yr_0to7days_csba").empty(); //(json[0].r_death_number_less_1yr_0to7days_csba);

    $("#death_number_less_1yr_8to28days_fwa").empty(); //(json[0].r_death_number_less_1yr_8to28days_fwa);
    //                        $("#death_number_less_1yr_8to28days_csba").empty(); //(json[0].r_death_number_less_1yr_8to28days_csba);

    $("#death_number_less_1yr_29dystoless1yr_fwa").empty(); //(json[0].r_death_number_less_1yr_29dystoless1yr_fwa);

    $("#death_number_less_1yr_tot_fwa").empty(); //(json[0].r_death_number_less_1yr_tot_fwa);

    $("#death_number_1yrto5yr_fwa").empty(); //(json[0].r_death_number_1yrto5yr_fwa);

    $("#death_number_maternal_death_fwa").empty(); //(json[0].r_death_number_maternal_death_fwa);
    //                        $("#death_number_maternal_death_csba").empty(); //(json[0].r_death_number_maternal_death_csba);

    $("#death_number_other_death_fwa").empty(); //(json[0].r_death_number_other_death_fwa);

    $("#death_number_all_death_fwa").empty(); //(json[0].r_death_number_all_death_fwa);

    $("#iron_folicacid_extrafood_counsiling_preg_woman").empty(); //(json[0].r_iron_folicacid_extrafood_counsiling_preg_woman);
    $("#iron_folicacid_extrafood_counsiling_child_0to23months").empty(); //(json[0].r_iron_folicacid_extrafood_counsiling_child_0to23months);

    $("#bfeeding_complementary_food_counsiling_preg_woman").empty(); //(json[0].r_bfeeding_complementary_food_counsiling_preg_woman);
    $("#bfeeding_complementary_food_counsiling_child_0to23months").empty(); //(json[0].r_bfeeding_complementary_food_counsiling_child_0to23months);


    $("#birth_1hr_bfeed_0to6mon").empty(); //(json[0].r_birth_1hr_bfeed_0to6mon);

    $("#birth_only_bfeed_0to6mon").empty(); //(json[0].r_birth_only_bfeed_0to6mon);


    $("#mnp_given_6to23mon").empty(); //(json[0].r_mnp_given_6to23mon);
    //                        $("#mnp_given_24toless60mon").empty(); //(json[0].r_mnp_given_24toless60mon);

    $("#sam_child_0to6mon").empty(); //(json[0].r_sam_child_0to6mon);
    $("#sam_child_6to23mon").empty(); //(json[0].r_sam_child_6to23mon);
    $("#sam_child_24toless60mon").empty(); //(json[0].r_sam_child_24toless60mon);

    $("#mam_child_0to6mon").empty(); //(json[0].r_mam_child_0to6mon);
    $("#mam_child_6to23mon").empty(); //(json[0].r_mam_child_6to23mon);
    $("#mam_child_24toless60mon").empty(); //(json[0].r_mam_child_24to60mon);


    //=====================Bottom================
    $("#r_pre_storage_1").empty();
    $("#r_curr_m_found_1").empty();
    $("#r_curr_m_total_storage_1").empty();
    $("#r_adjust_plus_1").empty();
    $("#r_adjust_minus_1").empty();
    $("#r_all_total_1").empty();
    $("#r_curr_m_delivered_1").empty();
    $("#r_remaining_1").empty();

    $("#r_pre_storage_2").empty();
    $("#r_curr_m_found_2").empty();
    $("#r_curr_m_total_storage_2").empty();
    $("#r_adjust_plus_2").empty();
    $("#r_adjust_minus_2").empty();
    $("#r_all_total_2").empty();
    $("#r_curr_m_delivered_2").empty();
    $("#r_remaining_2").empty();

    $("#r_pre_storage_3").empty();
    $("#r_curr_m_found_3").empty();
    $("#r_curr_m_total_storage_3").empty();
    $("#r_adjust_plus_3").empty();
    $("#r_adjust_minus_3").empty();
    $("#r_all_total_3").empty();
    $("#r_curr_m_delivered_3").empty();
    $("#r_remaining_3").empty();

    $("#r_pre_storage_4").empty();
    $("#r_curr_m_found_4").empty();
    $("#r_curr_m_total_storage_4").empty();
    $("#r_adjust_plus_4").empty();
    $("#r_adjust_minus_4").empty();
    $("#r_all_total_4").empty();
    $("#r_curr_m_delivered_4").empty();
    $("#r_remaining_4").empty();

    $("#r_pre_storage_5").empty();
    $("#r_curr_m_found_5").empty();
    $("#r_curr_m_total_storage_5").empty();
    $("#r_adjust_plus_5").empty();
    $("#r_adjust_minus_5").empty();
    $("#r_all_total_5").empty();
    $("#r_curr_m_delivered_5").empty();
    $("#r_remaining_5").empty();

    $("#r_pre_storage_6").empty();
    $("#r_curr_m_found_6").empty();
    $("#r_curr_m_total_storage_6").empty();
    $("#r_adjust_plus_6").empty();
    $("#r_adjust_minus_6").empty();
    $("#r_all_total_6").empty();
    $("#r_curr_m_delivered_6").empty();
    $("#r_remaining_6").empty();

    $("#r_pre_storage_7").empty();
    $("#r_curr_m_found_7").empty();
    $("#r_curr_m_total_storage_7").empty();
    $("#r_adjust_plus_7").empty();
    $("#r_adjust_minus_7").empty();
    $("#r_all_total_7").empty();
    $("#r_curr_m_delivered_7").empty();
    $("#r_remaining_7").empty();

    $("#r_pre_storage_8").empty();
    $("#r_curr_m_found_8").empty();
    $("#r_curr_m_total_storage_8").empty();
    $("#r_adjust_plus_8").empty();
    $("#r_adjust_minus_8").empty();
    $("#r_all_total_8").empty();
    $("#r_curr_m_delivered_8").empty();
    $("#r_remaining_8").empty();

    $("#r_pre_storage_9").empty();
    $("#r_curr_m_found_9").empty();
    $("#r_curr_m_total_storage_9").empty();
    $("#r_adjust_plus_9").empty();
    $("#r_adjust_minus_9").empty();
    $("#r_all_total_9").empty();
    $("#r_curr_m_delivered_9").empty();
    $("#r_remaining_9").empty();


}
