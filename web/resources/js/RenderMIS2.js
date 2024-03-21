var fpiData = {
    nsv_inspired_fpi: 0,
    av_van_display_fpi: 0,
    elco_day_count_fpi: 0,
    no_of_elco_count_fpi: 0,
    fwa_register_fpi: 0,
    yard_meeting_fpi: 0,
    fortnightly_meeting_fpi: 0,
    union_fp_committee_fpi: 0,
    satellite_clinic_presence_fpi: 0
}
var MIS2 = {
    8: {render: function (data, providers, json, mis2, lmis) {
            $('#monthyear').html(" <b>" + $('#month option:selected').text() + "/ " + e2b($('#year option:selected').text()) + " ইং </b>");
            $('#unionValue').html(" <b>" + $('#union option:selected').text().split("[")[0] + "</b>");
            $('#upazilaValue').html(" <b>" + $('#upazila option:selected').text().split("[")[0] + "</b>");
            $('#districtValue').html(" <b>" + $('#district option:selected').text().split("[")[0] + "</b>");

            $('#mis2Page1').html("");
            $('#mis2Page2').html("");
            $('#mis2Page3').html("");
            $('#mis2Page4').html("");
            $('#mis2Page5').html("");
            $('#mis2Page6').html("");
            $('#mis2Page7').html("");
            $('#mis2Page8').html("");
            var cal = new Calc(json);

            $('#totalWorker').html(e2b(providers.length));
            $('#totalSubmittedWorker').html(e2b(json.length));


            // $('#car').html(e2b(cal.avg('r_car').toFixed(2)));
            $('#r_unit_all_total_tot1').html(e2b(cal.sum.r_unit_all_total));
            $('#r_unit_capable_elco_tot1').html(e2b(cal.sum.r_unit_capable_elco_tot_2));
            var car = e2b(((cal.sum.r_unit_all_total / cal.sum.r_unit_capable_elco_tot_2) * 100).toFixed(2));
            $('#car').html(car);

            var one = "-";
            for (var j = 0; j < providers.length; j++) {

                var isSubmitted = false;
                for (var i = 0; i < json.length; i++) {
                    if (providers[j].fwaunit == json[i].r_unit_1) {

                        isSubmitted = true;
                        var Page1 = "<tr>"
                                + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                + "<td>" + e2b(json[i].r_unit_capable_elco_tot_2) + "</td>"
                                + "<td>" + e2b(json[i].r_old_pill_3) + "</td>"
                                + "<td>" + e2b(json[i].r_new_pill_4) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_month_pill_5) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_m_left_pill_no_method_6) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_m_left_pill_oth_method_7) + "</td>"
                                + "<td>" + e2b(json[i].r_old_condom_8) + "</td>"
                                + "<td>" + e2b(json[i].r_new_condom_9) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_month_condom_10) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_m_left_condom_no_method_11) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_m_left_condom_oth_method_12) + "</td>"
                                + "<td>" + e2b(json[i].r_old_injectable) + "</td>"
                                + "<td>" + e2b(json[i].r_new_injectable) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_month_injectable) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_m_left_inj_no_method) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_m_left_inj_oth_method) + "</td>"
                                + "<td>" + e2b(json[i].r_old_iud) + "</td>"
                                + "<td>" + e2b(json[i].r_new_iud) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_month_iud) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_m_left_iud_no_method) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_m_left_iud_oth_method) + "</td>"
                                + "<td>" + e2b(json[i].r_old_implant) + "</td>"
                                + "<td>" + e2b(json[i].r_new_implant) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_month_implant) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_m_left_implant_no_method) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_m_left_implant_oth_method) + "</td>"
                                + "<td>" + e2b(json[i].r_old_permanent_man) + "</td>"
                                + "<td>" + e2b(json[i].r_new_permanent_man) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_month_permanent_man) + "</td>"
                                + "<td>" + e2b(json[i].r_old_permanent_woman) + "</td>"
                                + "<td>" + e2b(json[i].r_new_permanent_woman) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_month_permanent_woman) + "</td>"
                                + "<td>" + e2b(json[i].r_sent_method_all_tot) + "</td>"
                                + "<td>" + e2b(json[i].r_sent_side_effect_all_tot) + "</td>"
                                + "<td>" + e2b(json[i].r_unit_all_total) + "</td>"
                                + "<td>" + e2b(((json[i].r_unit_all_total / json[i].r_unit_capable_elco_tot_2) * 100).toFixed(2)) + "</td>"
                                + "</tr>";
                        $('#mis2Page1').append(Page1);

                        var Page2 = "<tr>"
                                + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_month_preg_new_fwa_38) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_month_preg_old_fwa_39) + "</td>"
                                + "<td>" + e2b(json[i].r_curr_month_preg_tot_fwa_40) + "</td>"
                                + "<td>" + e2b(json[i].r_priv_month_preg_tot_fwa_41) + "</td>"
                                + "<td>" + e2b(json[i].r_unit_preg_tot_fwa1_42) + "</td>"
                                + "<td>" + e2b(json[i].r_preg_anc_service_visit1_fwa_43) + "</td>"
                                + "<td>" + e2b(json[i].r_preg_anc_service_visit2_fwa_44) + "</td>"
                                + "<td>" + e2b(json[i].r_preg_anc_service_visit3_fwa_45) + "</td>"
                                + "<td>" + e2b(json[i].r_preg_anc_service_visit4_fwa_46) + "</td>"
                                + "<td>" + e2b(json[i].r_delivary_service_home_trained_fwa_47) + "</td>"
                                + "<td>" + e2b(json[i].r_delivary_service_home_untrained_fwa_48) + "</td>"
                                + "<td>" + e2b(json[i].r_delivary_service_hospital_normal_fwa_49) + "</td>"
                                + "<td>" + e2b(json[i].r_delivary_service_hospital_cesarean_fwa_50) + "</td>"
                                + "<td>" + e2b(json[i].r_pnc_mother_visit1_fwa_51) + "</td>"
                                + "<td>" + e2b(json[i].r_pnc_mother_visit2_fwa_52) + "</td>"
                                + "<td>" + e2b(json[i].r_pnc_mother_visit3_fwa_53) + "</td>"
                                + "<td>" + e2b(json[i].r_pnc_mother_visit4_fwa_54) + "</td>"
                                + "<td>" + e2b(json[i].r_pnc_newborn_visit1_fwa_55) + "</td>"
                                + "<td>" + e2b(json[i].r_pnc_newborn_visit2_fwa_56) + "</td>"
                                + "<td>" + e2b(json[i].r_pnc_newborn_visit3_fwa_57) + "</td>"
                                + "<td>" + e2b(json[i].r_pnc_newborn_visit4_fwa_58) + "</td>"
                                + "<td>" + e2b(json[i].r_ref_risky_preg_cnt_fwa_59) + "</td>"
                                + "<td>" + e2b(json[i].r_childless_couple_adviced_fwa_60) + "</td>"
                                + "<td>" + e2b(json[i].r_childless_couple_refered_fwa_61) + "</td>"
                                + "<td>" + e2b(json[i].r_tt_women_1st_fwa_62) + "</td>"
                                + "<td>" + e2b(json[i].r_tt_women_2nd_fwa_63) + "</td>"
                                + "<td>" + e2b(json[i].r_tt_women_3rd_fwa_64) + "</td>"
                                + "<td>" + e2b(json[i].r_tt_women_4th_fwa_65) + "</td>"
                                + "<td>" + e2b(json[i].r_tt_women_5th_fwa_66) + "</td>"
                                + "<td>" + e2b(json[i].r_ecp_taken_fwa_67) + "</td>"
                                + "<td>" + e2b(json[i].r_misoprostol_taken_fwa_68) + "</td>"
                                + "<td>" + e2b(json[i].r_health_change_adolescent_fwa_69) + "</td>"
                                + "<td>" + e2b(json[i].r_child_marriage_preg_disadvantage_fwa_70) + "</td>"
                                + "<td>" + e2b(json[i].r_iron_folic_acid_fwa_71) + "</td>"
                                + "<td>" + e2b(json[i].r_sexual_disease_fwa_72) + "</td>"
                                + "</tr>";
                        $('#mis2Page2').append(Page2);

                        var Page3 = "<tr>"
                                + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                + "<td>" + e2b(json[i].r_satelite_clinic_presence_fwa_73) + "</td>"
                                + "<td>" + e2b(json[i].r_epi_session_presence_fwa_74) + "</td>"
                                + "<td>" + e2b(json[i].r_community_clinic_presence_fwa_75) + "</td>"
                                + "<td>" + e2b(json[i].r_newborn_1min_washed_fwa_76) + "</td>"
                                + "<td>" + e2b(json[i].r_newborn_71_chlorohexidin_used_fwa_77) + "</td>"
                                + "<td>" + e2b(json[i].r_vaccin_child_bcg_fwa_78) + "</td>"
                                + "<td>" + e2b(json[i].r_vaccin_0_18_months_opv_pcv_1_fwa_79) + "</td>"
                                + "<td>" + e2b(json[i].r_vaccin_0_18_months_opv_pcv_2_fwa_80) + "</td>"
                                + "<td>" + e2b(json[i].r_vaccin_0_18_months_opv_3_fwa_81) + "</td>"
                                + "<td>" + e2b(json[i].r_vaccin_0_18_months_pcv3_fwa_82) + "</td>"
                                + "<td>" + e2b(json[i].r_vaccin_0_18_months_mr_opv4_fwa_83) + "</td>"
                                + "<td>" + e2b(json[i].r_vaccin_0_18_ham_fwa_84) + "</td>"
                                + "<td>" + e2b(json[i].r_referred_child_dangerous_disease_fwa_85) + "</td>"
                                + "<td>" + e2b(json[i].r_referred_child_neumonia_fwa_86) + "</td>"
                                + "<td>" + e2b(json[i].r_referred_child_diahoea_fwa_87) + "</td>"
                                + "<td>" + e2b(json[i].r_tot_live_birth_fwa_88) + "</td>"
                                + "<td>" + e2b(json[i].r_less_weight_birth_fwa_89) + "</td>"
                                + "<td>" + e2b(json[i].r_immature_birth_less37weeks_fwa_90) + "</td>"
                                + "<td>" + e2b(json[i].r_still_birth_fwa_91) + "</td>"
                                + "<td>" + e2b(json[i].r_death_less_1yr_0_7days_fwa_92) + "</td>"
                                + "<td>" + e2b(json[i].r_death_less_1yr_8_28days_fwa_93) + "</td>"
                                + "<td>" + e2b(json[i].r_death_less_1yr_29dys_less1yr_fwa_94) + "</td>"
                                + "<td>" + e2b(json[i].r_death_less_1yr_tot_fwa_95) + "</td>"
                                + "<td>" + e2b(json[i].r_death_1yr_less_5yr_fwa_96) + "</td>"
                                + "<td>" + e2b(json[i].r_death_maternal_death_fwa_97) + "</td>"
                                + "<td>" + e2b(json[i].r_death_other_fwa_98) + "</td>"
                                + "<td>" + e2b(json[i].r_death_all_fwa_99) + "</td>"
                                + "</tr>";
                        $('#mis2Page3').append(Page3);

                        var Page4 = "<tr>"
                                + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                + "<td>" + e2b(json[i].r_iron_folic_extrafood_counsil_preg_woman_100) + "</td>"
                                + "<td>" + e2b(json[i].r_iron_folic_extrafood_counsil_mother_0to23m_101) + "</td>"
                                + "<td>" + e2b(json[i].r_iron_folic_pill_distribute_preg_woman_102) + "</td>"
                                + "<td>" + e2b(json[i].r_iron_folic_pill_distribute_mother_0to23m_103) + "</td>"
                                + "<td>" + e2b(json[i].r_bfeeding_comp_food_counsil_preg_woman_104) + "</td>"
                                + "<td>" + e2b(json[i].r_bfeeding_comp_food_counsil_mother_0to23m_105) + "</td>"
                                + "<td>" + e2b(json[i].r_child_mnp_feeding_mother_0to23m_106) + "</td>"
                                + "<td>" + e2b(json[i].r_birth_1hr_bfeed_0_less_6mon_107) + "</td>"
                                + "<td>" + e2b(json[i].r_birth_only_bfeed_0_less_6mon_108) + "</td>"
                                + "<td>" + e2b(json[i].r_child_afood_6_less24mon_109) + "</td>"
                                + "<td>" + e2b(json[i].r_child_afood_24_less60mon_110) + "</td>"
                                + "<td>" + e2b(json[i].r_mnp_given_6_less24mon_111) + "</td>"
                                + "<td>" + e2b(json[i].r_mam_child_0_less_6mon_112) + "</td>"
                                + "<td>" + e2b(json[i].r_mam_child_6_less_24mon_113) + "</td>"
                                + "<td>" + e2b(json[i].r_mam_child_24_less_60mon_114) + "</td>"
                                + "<td>" + e2b(json[i].r_sam_child_0_less_6mon_115) + "</td>"
                                + "<td>" + e2b(json[i].r_sam_child_6_less_24mon_116) + "</td>"
                                + "<td>" + e2b(json[i].r_sam_child_24_less_60mon_117) + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "</tr>";
                        $('#mis2Page4').append(Page4);

                        var Page5 = "<tr>"
                                + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "<td>" + one + "</td>"
                                + "</tr>";
                        $('#mis2Page5').append(Page5);

                        //LMIS part
                        lmis = null
                        if (lmis != null) {
                            for (var k = 0; k < lmis.length; k++) {
                                if (providers[j].providerid == lmis[k].providerid) {

                                    var Page6 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td colspan='10'>" + providers[j].provname + "</td>"
                                            + "<td>" + e2b(lmis[k].openingbalance_sukhi) + "</td>"
                                            + "<td>" + e2b(lmis[k].receiveqty_sukhi) + "</td>"
                                            + "<td>" + e2b(lmis[k].current_month_stock_sukhi) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_plus_sukhi) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_minus_sukhi) + "</td>"
                                            + "<td>" + e2b(lmis[k].total_sukhi) + "</td>"
                                            + "<td>" + e2b(lmis[k].distribution_sukhi) + "</td>"
                                            + "<td>" + e2b(lmis[k].closingbalance_sukhi) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + e2b(lmis[k].openingbalance_apon) + "</td>"
                                            + "<td>" + e2b(lmis[k].receiveqty_apon) + "</td>"
                                            + "<td>" + e2b(lmis[k].current_month_stock_apon) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_plus_apon) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_minus_apon) + "</td>"
                                            + "<td>" + e2b(lmis[k].total_apon) + "</td>"
                                            + "<td>" + e2b(lmis[k].distribution_apon) + "</td>"
                                            + "<td>" + e2b(lmis[k].closingbalance_apon) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + e2b(lmis[k].openingbalance_condom) + "</td>"
                                            + "<td>" + e2b(lmis[k].receiveqty_condom) + "</td>"
                                            + "<td>" + e2b(lmis[k].current_month_stock_condom) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_plus_condom) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_minus_condom) + "</td>"
                                            + "<td>" + e2b(lmis[k].total_condom) + "</td>"
                                            + "<td>" + e2b(lmis[k].distribution_condom) + "</td>"
                                            + "<td>" + e2b(lmis[k].closingbalance_condom) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "</tr>";
                                    $('#mis2Page6').append(Page6);
                                    var Page7 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td colspan='10'>" + providers[j].provname + "</td>"
                                            + "<td>" + e2b(lmis[k].openingbalance_inject_vayal) + "</td>"
                                            + "<td>" + e2b(lmis[k].receiveqty_inject_vayal) + "</td>"
                                            + "<td>" + e2b(lmis[k].current_month_stock_inject_vayal) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_plus_inject_vayal) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_minus_inject_vayal) + "</td>"
                                            + "<td>" + e2b(lmis[k].total_inject_vayal) + "</td>"
                                            + "<td>" + e2b(lmis[k].distribution_inject_vayal) + "</td>"
                                            + "<td>" + e2b(lmis[k].closingbalance_inject_vayal) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + e2b(lmis[k].openingbalance_inject_syringe) + "</td>"
                                            + "<td>" + e2b(lmis[k].receiveqty_inject_syringe) + "</td>"
                                            + "<td>" + e2b(lmis[k].current_month_stock_inject_syringe) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_plus_inject_syringe) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_minus_inject_syringe) + "</td>"
                                            + "<td>" + e2b(lmis[k].total_inject_syringe) + "</td>"
                                            + "<td>" + e2b(lmis[k].distribution_inject_syringe) + "</td>"
                                            + "<td>" + e2b(lmis[k].closingbalance_inject_syringe) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + e2b(lmis[k].openingbalance_ecp) + "</td>"
                                            + "<td>" + e2b(lmis[k].receiveqty_ecp) + "</td>"
                                            + "<td>" + e2b(lmis[k].current_month_stock_ecp) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_plus_ecp) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_minus_ecp) + "</td>"
                                            + "<td>" + e2b(lmis[k].total_ecp) + "</td>"
                                            + "<td>" + e2b(lmis[k].distribution_ecp) + "</td>"
                                            + "<td>" + e2b(lmis[k].closingbalance_ecp) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "</tr>";
                                    $('#mis2Page7').append(Page7);
                                    var Page8 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td colspan='10'>" + providers[j].provname + "</td>"
                                            + "<td>" + e2b(lmis[k].openingbalance_misoprostol) + "</td>"
                                            + "<td>" + e2b(lmis[k].receiveqty_misoprostol) + "</td>"
                                            + "<td>" + e2b(lmis[k].current_month_stock_misoprostol) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_plus_misoprostol) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_minus_misoprostol) + "</td>"
                                            + "<td>" + e2b(lmis[k].total_misoprostol) + "</td>"
                                            + "<td>" + e2b(lmis[k].distribution_misoprostol) + "</td>"
                                            + "<td>" + e2b(lmis[k].closingbalance_misoprostol) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + e2b(lmis[k].openingbalance_mnp) + "</td>"
                                            + "<td>" + e2b(lmis[k].receiveqty_mnp) + "</td>"
                                            + "<td>" + e2b(lmis[k].current_month_stock_mnp) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_plus_mnp) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_minus_mnp) + "</td>"
                                            + "<td>" + e2b(lmis[k].total_mnp) + "</td>"
                                            + "<td>" + e2b(lmis[k].distribution_mnp) + "</td>"
                                            + "<td>" + e2b(lmis[k].closingbalance_mnp) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + e2b(lmis[k].openingbalance_iron) + "</td>"
                                            + "<td>" + e2b(lmis[k].receiveqty_iron) + "</td>"
                                            + "<td>" + e2b(lmis[k].current_month_stock_iron) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_plus_iron) + "</td>"
                                            + "<td>" + e2b(lmis[k].adjustment_minus_iron) + "</td>"
                                            + "<td>" + e2b(lmis[k].total_iron) + "</td>"
                                            + "<td>" + e2b(lmis[k].distribution_iron) + "</td>"
                                            + "<td>" + e2b(lmis[k].closingbalance_iron) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "</tr>";
                                    $('#mis2Page8').append(Page8);
                                }
                            }
                        } else {
                            var Page6 = "<tr>"
                                    + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                    + "<td colspan='10'>" + providers[j].provname + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "</tr>";
                            $('#mis2Page6').append(Page6);
                            var Page7 = "<tr>"
                                    + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                    + "<td colspan='10'>" + providers[j].provname + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "</tr>";
                            $('#mis2Page7').append(Page7);

                            var Page8 = "<tr>"
                                    + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                    + "<td colspan='10'>" + providers[j].provname + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "<td>" + one + "</td>"
                                    + "</tr>";
                            $('#mis2Page8').append(Page8);
                        }
                    }
                }

                if (!isSubmitted) {
                    $('#mis2Page1').append("<tr class='not-submitted'>\n" + renderRow(37, '&nbsp;', providers[j].fwaunit, "") + "</tr>");
                    $('#mis2Page2').append("<tr class='not-submitted'>\n" + renderRow(36, '&nbsp;', providers[j].fwaunit, "") + "</tr>");
                    $('#mis2Page3').append("<tr class='not-submitted'>\n" + renderRow(28, '&nbsp;', providers[j].fwaunit, "") + "</tr>");
                    $('#mis2Page4').append("<tr class='not-submitted'>\n" + renderRow(29, '&nbsp;', providers[j].fwaunit, "") + "</tr>");

                    $('#mis2Page5').append("<tr class='not-submitted'>\n" + renderRow(27, '&nbsp;', providers[j].fwaunit, "") + "</tr>");
                    $('#mis2Page6').append("<tr class='not-submitted'>\n" + renderRow(28, '&nbsp;', providers[j].fwaunit, providers[j].provname) + "</tr>");
                    $('#mis2Page7').append("<tr class='not-submitted'>\n" + renderRow(28, '&nbsp;', providers[j].fwaunit, providers[j].provname) + "</tr>");
                    $('#mis2Page8').append("<tr class='not-submitted'>\n" + renderRow(28, '&nbsp;', providers[j].fwaunit, providers[j].provname) + "</tr>");
                }
            }
            $('#mis2Page1').append("<tr>\n" + getLastRow8(cal, 1, car) + "</tr>");
            $('#mis2Page2').append("<tr>\n" + getLastRow8(cal, 2, car) + "</tr>");
            $('#mis2Page3').append("<tr>\n" + getLastRow8(cal, 3, car) + "</tr>");
            $('#mis2Page4').append("<tr>\n" + getLastRow8(cal, 4, car) + "</tr>");

            $('#mis2Page5').append("<tr>\n" + getLastRow8(cal, 5, car) + "</tr>");
            $('#mis2Page6').append("<tr>\n" + getLastRow8(cal, 6, car) + "</tr>");
            $('#mis2Page7').append("<tr>\n" + getLastRow8(cal, 6, car) + "</tr>");
            $('#mis2Page8').append("<tr>\n" + getLastRow8(cal, 6, car) + "</tr>");


        }
    },
    9: {render: function (data, providers, json, mis2, lmis) {
            console.log(data, providers, json, mis2, lmis);
            submissionDate = data.submissionDate
            var providerName = $("#provCode :selected").text().replace(/\s?[\[\d\]]/g, '');
            $("#providerName").html("&nbsp;&nbsp;<b>" + providerName + "</b>");
            if (submissionDate === undefined) {
                submissionDate = "........................................";
            } else {
                submissionDate = e2b(convertToUserDate(submissionDate));
            }
            $("#submissionDate").html("&nbsp;&nbsp;&nbsp;&nbsp;<b>" + submissionDate + "</b>");

            mis2.setArea( $.app.monthBangla[$('#month').val()] + "/ " + e2b($('#year option:selected').text()) + " ইং", $('#union option:selected').text().split("[")[0], $('#upazila option:selected').text().split("[")[0], $('#district option:selected').text().split("[")[0]);
            mis2.cleanMIS2();

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
        }}
}

$(document).ready(function () {
    $('#printTableBtn').click(function () {
        $('.mis2').each(function () {
            $(this).css({
                "page-break-after": "always"
            });
        });
        // window.print();
        var contents = $("#printContent").html();
        var frame1 = $('<iframe />');
        frame1[0].name = "frame1";
        frame1.css({"position": "absolute", "top": "-1000000px"});
        $("body").append(frame1);
        var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
        frameDoc.document.open();
        frameDoc.document.write('<html><head><title>eMIS Initiative</title>');
        frameDoc.document.write('</head><body>');
        frameDoc.document.write('<style>.r-v {white-space: nowrap;writing-mode: vertical-rl;transform: rotate(180deg);vertical-align: bottom!important;}   #logo{margin-top: 10px;margin-left: 5px;width:65px;height:65px;}</style>');
        frameDoc.document.write('<style>table, th{font-weight:normal} , td{} .tg  {border-collapse:collapse;border-spacing:0;} #topheader{border: none; margin-bottom:10px;}</style>');
        frameDoc.document.write('<style>.tg td{font-family: SolaimanLipi;font-size:12px;padding:7px 9px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}</style>');
        frameDoc.document.write('<style>.tf td{font-family: SolaimanLipi;font-size:12px;padding:0px!important;padding-right: 26px!important;border-width:0px;overflow:hidden;}</style>');
        frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;text-align: center;vertical-align: bottom!important} .head{ font-weight:normal!important;text-align:center}</style>');
        frameDoc.document.write('<style>#slogan{text-align:center;border: 1px solid #000!important;width: 180px;text-align: center;padding: 2px;}</style>');
        frameDoc.document.write('<style>.lmis-title{ text-align:center!important;} .lmis-title-table{margin: auto!important;width: 60%!important;padding: 20px!important;} .car-table{float: right!important;}</style>');
        frameDoc.document.write(contents);
        frameDoc.document.write('</body></html>');
        frameDoc.document.close();
        setTimeout(function () {
            window.frames["frame1"].focus();
            window.frames["frame1"].print();
            frame1.remove();
        }, 500);
    });
});

function setFPIDataSum() {
    if (Template.response.fpiSubmittedJson != undefined) {
        var fpiData_ = new Calc(Template.response.fpiSubmittedJson)
        fpiData.nsv_inspired_fpi = fpiData_.sum.nsv_inspired_fpi;
        fpiData.av_van_display_fpi = fpiData_.sum.av_van_display_fpi;
        fpiData.elco_day_count_fpi = fpiData_.sum.elco_day_count_fpi;
        fpiData.no_of_elco_count_fpi = fpiData_.sum.no_of_elco_count_fpi;
        fpiData.fwa_register_fpi = fpiData_.sum.fwa_register_fpi;
        fpiData.yard_meeting_fpi = fpiData_.sum.yard_meeting_fpi;
        fpiData.satellite_clinic_presence_fpi = fpiData_.sum.satellite_clinic_presence_fpi;
    }
}
function getLastRow(json, page, car) {
    var row = "", one = "";
    setFPIDataSum();
    if (page == 1) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + json.sum.r_unit_capable_elco_tot + "</td>"
                + "<td>" + json.sum.r_old_pill_normal + "</td>"
                + "<td>" + json.sum.r_new_pill_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_pill_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_pill_normal + "</td>"
                + "<td>" + json.sum.r_curr_m_left_pill_oth_method_normal + "</td>"
                + "<td>" + json.sum.r_old_pill_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_pill_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_pill_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_pill_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_pill_oth_method_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_pill_after_delivery + "</td>"
                + "<td>" + json.sum.r_pill_total + "</td>"
                + "<td>" + json.sum.r_old_condom_normal + "</td>"
                + "<td>" + json.sum.r_new_condom_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_condom_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_condom_normal + "</td>"
                + "<td>" + json.sum.r_curr_m_left_condom_oth_method_normal + "</td>"
                + "<td>" + json.sum.r_old_condom_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_condom_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_condom_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_condom_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_condom_oth_method_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_condom_after_delivery + "</td>"
                + "<td>" + json.sum.r_condom_total + "</td>"
                + "<td>" + json.sum.r_old_inject_normal + "</td>"
                + "<td>" + json.sum.r_new_inject_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_inject_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_inject_normal + "</td>"
                + "<td>" + json.sum.r_curr_m_left_inj_oth_method_normal + "</td>"
                + "<td>" + json.sum.r_old_inject_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_inject_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_inject_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_inject_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_inj_oth_method_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_inject_after_delivery + "</td>"
                + "<td>" + json.sum.r_injectable_total + "</td>";

    } else if (page == 2) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + json.sum.r_old_iud_normal + "</td>"
                + "<td>" + json.sum.r_new_iud_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_iud_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_iud_normal + "</td>"
                + "<td>" + json.sum.r_curr_m_left_iud_oth_method_normal + "</td>"
                + "<td>" + json.sum.r_old_iud_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_iud_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_iud_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_iud_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_iud_oth_method_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_iud_after_delivery + "</td>"
                + "<td>" + json.sum.r_iud_total + "</td>"
                + "<td>" + json.sum.r_old_implant_normal + "</td>"
                + "<td>" + json.sum.r_new_implant_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_implant_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_implant_normal + "</td>"
                + "<td>" + json.sum.r_curr_m_left_implant_oth_method_normal + "</td>"
                + "<td>" + json.sum.r_old_implant_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_implant_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_implant_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_implant_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_implant_oth_method_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_implan_after_delivery + "</td>"
                + "<td>" + json.sum.r_implant_total + "</td>"
                + "<td>" + json.sum.r_old_permanent_man_normal + "</td>"
                + "<td>" + json.sum.r_new_permanent_man_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_permanent_normal_man + "</td>"
                + "<td>" + json.sum.r_old_permanent_man_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_permanent_man_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_permanent_after_delivery_man + "</td>"
                + "<td>" + json.sum.r_permanent_method_men_total + "</td>"
                + "<td>" + json.sum.r_old_permanent_woman_normal + "</td>"
                + "<td>" + json.sum.r_new_permanent_woman_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_permanent_normal_woman + "</td>"
                + "<td>" + json.sum.r_old_permanent_woman_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_permanent_woman_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_permanent_after_delivery_woman + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_all_tot + "</td>"
                + "<td>" + json.sum.r_total_permanent_method + "</td>"
                + "<td>" + json.sum.r_curr_month_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_unit_all_total_tot + "</td>"
//                + "<td>" + json.sum.r_car.toFixed(2) + "</td>";
                + "<td>" + car + "</td>";
        //alert(json.sum.r_car.toFixed(2));

    } else if (page == 3) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + json.sum.r_sent_method_all_tot + "</td>"
                + "<td>" + json.sum.r_sent_side_effect_all_tot + "</td>"
                + "<td>" + json.sum.r_curr_m_shown_capable_elco_tot + "</td>"
                + "<td>" + json.sum.r_priv_m_shown_capable_elco_tot + "</td>"
                + "<td>" + json.sum.r_curr_m_v_new_elco_tot + "</td>"
                + "<td>" + json.sum.r_curr_month_preg_new_fwa + "</td>"
                + "<td>" + json.sum.r_curr_month_preg_old_fwa + "</td>"
                + "<td>" + json.sum.r_curr_month_preg_tot_fwa + "</td>"
                + "<td>" + json.sum.r_priv_month_tot_preg_fwa + "</td>"
                + "<td>" + json.sum.r_unit_tot_preg_fwa + "</td>"
                + "<td>" + json.sum.r_abortion_or_miscarriage + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit1_fwa + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit2_fwa + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit3_fwa + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit4_fwa + "</td>"
                + "<td>" + json.sum.r_preg_anc_counselling_after_delivery_fwa + "</td>"
                + "<td>" + json.sum.r_preg_anc_misoprostol_supplied_fwa + "</td>"
                + "<td>" + json.sum.r_preg_anc_chlorohexidin_supplied_fwa + "</td>"
                + "<td>" + json.sum.r_delivary_service_home_trained_fwa + "</td>"
                + "<td>" + json.sum.r_delivary_service_home_untrained_fwa + "</td>"
                + "<td>" + json.sum.r_delivary_service_hospital_normal_fwa + "</td>"
                + "<td>" + json.sum.r_delivary_service_hospital_operation_fwa + "</td>"
                + "<td>" + json.sum.r_delivary_service_misoprostol_taken + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit1_fwa + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit2_fwa + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit3_fwa + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit4_fwa + "</td>"
                + "<td>" + json.sum.r_pnc_mother_home_delivery_training_fwa + "</td>"
                + "<td>" + json.sum.r_pnc_mother_family_planning_counselling_fwa + "</td>"
                + "<td>" + json.sum.r_newborn_1min_washed_fwa + "</td>"
                + "<td>" + json.sum.r_newborn_71_chlorohexidin_used_fwa + "</td>"
                + "<td>" + json.sum.r_newborn_with_mother_skin_fwa + "</td>"
                + "<td>" + json.sum.r_newborn_1hr_bfeeded_fwa + "</td>"
                + "<td>" + json.sum.r_newborn_diff_breathing_resassite_fwa + "</td>";

    } else if (page == 4) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + json.sum.r_pnc_newborn_visit1_fwa + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit2_fwa + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit3_fwa + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit4_fwa + "</td>"
                + "<td>" + json.sum.r_ref_risky_preg_cnt_fwa + "</td>"
                + "<td>" + json.sum.r_ref_eclampsia_mgso4_inj_refer_fwa + "</td>"
                + "<td>" + json.sum.r_ref_newborn_difficulty_fwa + "</td>"
                + "<td>" + json.sum.r_infertile_consultstatus + "</td>"
                + "<td>" + json.sum.r_infertile_referstatus + "</td>"
                + "<td>" + json.sum.r_tt_women_1st_fwa + "</td>"
                + "<td>" + json.sum.r_tt_women_2nd_fwa + "</td>"
                + "<td>" + json.sum.r_tt_women_3rd_fwa + "</td>"
                + "<td>" + json.sum.r_tt_women_4th_fwa + "</td>"
                + "<td>" + json.sum.r_tt_women_5th_fwa + "</td>"
                + "<td>" + json.sum.r_ecp_taken + "</td>"
                + "<td>" + json.sum.r_teen_counseling_adolescent_change_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_child_marriage_preg_effect_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_iron_folic_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_sexual_disease_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_healthy_balanced_diet_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_adolescence_violence_prevention_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_mental_prob_drug_addict_prevention_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_cleanliness_sanitary_pad_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_referred_fwa + "</td>"
                + "<td>" + one + "</td>";

    } else if (page == 5) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_bcg_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pentavalent_1_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pentavalent_2_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pentavalent_3_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pcv1_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pcv2_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pcv3_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_bopv_1_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_bopv_2_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_bopv_3_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_ipv_1_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_ipv_2_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_mr_1_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_mr_2_fwa + "</td>"
                + "<td>" + json.sum.r_referred_child_dangerous_disease_fwa + "</td>"
                + "<td>" + json.sum.r_referred_child_neumonia_fwa + "</td>"
                + "<td>" + json.sum.r_referred_child_diahoea_fwa + "</td>"
                + "<td>" + json.sum.r_tot_live_birth_fwa + "</td>"
                + "<td>" + json.sum.r_less_weight_birth_less_then_2500g_fwa + "</td>"
                + "<td>" + json.sum.r_less_weight_birth_less_then_2000g_fwa + "</td>"
                + "<td>" + json.sum.r_immature_birth_fwa + "</td>"
                + "<td>" + json.sum.r_still_birth_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_less_1yr_0to7days_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_less_1yr_8to28days_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_less_1yr_29dystoless1yr_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_less_1yr_tot_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_1yrto5yr_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_maternal_death_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_other_death_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_all_death_fwa + "</td>";

    } else if (page == 6) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + json.sum.r_iron_folicacid_extrafood_counsiling_preg_woman + "</td>"
                + "<td>" + json.sum.r_iron_folicacid_extrafood_counsiling_child_0to23months + "</td>"
                + "<td>" + json.sum.r_iron_folicacid_distribute_preg_woman + "</td>"
                + "<td>" + json.sum.r_iron_folicacid_distribute_child_0to23months + "</td>"
                + "<td>" + json.sum.r_bfeeding_complementary_food_counsiling_preg_woman + "</td>"
                + "<td>" + json.sum.r_bfeeding_complementary_food_counsiling_child_0to23months + "</td>"
                + "<td>" + json.sum.r_mnp_ounsiling_child_0to23months + "</td>"
                + "<td>" + json.sum.r_birth_only_bfeed_0to6mon + "</td>"
                + "<td>" + json.sum.r_v0_59_child_complementary_food_6to23mon + "</td>"
                + "<td>" + json.sum.r_v0_59_child_complementary_food_24to59mon + "</td>"
                + "<td>" + json.sum.r_mnp_given_6to23mon + "</td>"
                + "<td>" + json.sum.r_mnp_given_24toless60mon + "</td>"
                + "<td>" + json.sum.r_mam_child_0to6mon + "</td>"
                + "<td>" + json.sum.r_mam_child_6to23mon + "</td>"
                + "<td>" + json.sum.r_mam_child_24to60mon + "</td>"
                + "<td>" + json.sum.r_sam_child_0to6mon + "</td>"
                + "<td>" + json.sum.r_sam_child_6to23mon + "</td>"
                + "<td>" + json.sum.r_sam_child_24toless60mon + "</td>"
                + "<td>" + json.sum.r_satelite_clinic_presence + "</td>"
                + "<td>" + json.sum.r_epi_session_presence + "</td>"
                + "<td>" + json.sum.r_community_clinic_presence + "</td>"
                + "<td>" + json.sum.r_yard_meeting_presence + "</td>"
                + "<td>" + fpiData.nsv_inspired_fpi + "</td>"
                + "<td>" + fpiData.av_van_display_fpi + "</td>"
                + "<td>" + fpiData.elco_day_count_fpi + "</td>"
                + "<td>" + fpiData.no_of_elco_count_fpi + "</td>"
                + "<td>" + fpiData.fwa_register_fpi + "</td>"
                + "<td>" + fpiData.yard_meeting_fpi + "</td>"
                + "<td>" + fpiData.satellite_clinic_presence_fpi + "</td>";

    } else if (page == 7) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + json.sum.r_preg_anc_service_visit1_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit2_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit3_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit4_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_counselling_after_delivery_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_misoprostol_supplied_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_chlorohexidin_supplied_csba + "</td>"
                + "<td>" + json.sum.r_delivary_service_delivery_done_csba + "</td>"
                + "<td>" + json.sum.r_delivary_service_3rd_amtsl_csba + "</td>"
                + "<td>" + json.sum.r_delivary_service_misoprostol_taken_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit1_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit2_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit3_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit4_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_home_delivery_training_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_family_planning_counselling_csba + "</td>"
                + "<td>" + json.sum.r_newborn_1min_washed_csba + "</td>"
                + "<td>" + json.sum.r_newborn_71_chlorohexidin_used_csba + "</td>"
                + "<td>" + json.sum.r_newborn_with_mother_skin_csba + "</td>"
                + "<td>" + json.sum.r_newborn_1hr_bfeeded_csba + "</td>"
                + "<td>" + json.sum.r_newborn_diff_breathing_resassite_csba + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit1_csba + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit2_csba + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit3_csba + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit4_csba + "</td>"
                + "<td>" + json.sum.r_ref_risky_preg_cnt_csba + "</td>"
                + "<td>" + json.sum.r_ref_eclampsia_mgso4_inj_refer_csba + "</td>"
                + "<td>" + json.sum.r_ref_newborn_difficulty_csba + "</td>"
                + "<td>" + json.sum.r_tot_live_birth_csba + "</td>"
                + "<td>" + json.sum.r_immature_birth_csba + "</td>"
                + "<td>" + json.sum.r_still_birth_csba + "</td>";

    } else if (page == 8) {
        row = "<td colspan='11'>সর্বমোট</td>"
                + "<td>" + e2b(json.sum.openingbalance_sukhi) + "</td>"
                + "<td>" + e2b(json.sum.receiveqty_sukhi) + "</td>"
                + "<td>" + e2b(json.sum.current_month_stock_sukhi) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_plus_sukhi) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_minus_sukhi) + "</td>"
                + "<td>" + e2b(json.sum.total_sukhi) + "</td>"
                + "<td>" + e2b(json.sum.distribution_sukhi) + "</td>"
                + "<td>" + e2b(json.sum.closingbalance_sukhi) + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + e2b(json.sum.openingbalance_apon) + "</td>"
                + "<td>" + e2b(json.sum.receiveqty_apon) + "</td>"
                + "<td>" + e2b(json.sum.current_month_stock_apon) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_plus_apon) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_minus_apon) + "</td>"
                + "<td>" + e2b(json.sum.total_apon) + "</td>"
                + "<td>" + e2b(json.sum.distribution_apon) + "</td>"
                + "<td>" + e2b(json.sum.closingbalance_apon) + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + e2b(json.sum.openingbalance_condom) + "</td>"
                + "<td>" + e2b(json.sum.receiveqty_condom) + "</td>"
                + "<td>" + e2b(json.sum.current_month_stock_condom) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_plus_condom) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_minus_condom) + "</td>"
                + "<td>" + e2b(json.sum.total_condom) + "</td>"
                + "<td>" + e2b(json.sum.distribution_condom) + "</td>"
                + "<td>" + e2b(json.sum.closingbalance_condom) + "</td>"
                + "<td>" + one + "</td>";

    } else if (page == 9) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + e2b(json.sum.openingbalance_inject_vayal) + "</td>"
                + "<td>" + e2b(json.sum.receiveqty_inject_vayal) + "</td>"
                + "<td>" + e2b(json.sum.current_month_stock_inject_vayal) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_plus_inject_vayal) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_minus_inject_vayal) + "</td>"
                + "<td>" + e2b(json.sum.total_inject_vayal) + "</td>"
                + "<td>" + e2b(json.sum.distribution_inject_vayal) + "</td>"
                + "<td>" + e2b(json.sum.closingbalance_inject_vayal) + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + e2b(json.sum.openingbalance_inject_syringe) + "</td>"
                + "<td>" + e2b(json.sum.receiveqty_inject_syringe) + "</td>"
                + "<td>" + e2b(json.sum.current_month_stock_inject_syringe) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_plus_inject_syringe) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_minus_inject_syringe) + "</td>"
                + "<td>" + e2b(json.sum.total_inject_syringe) + "</td>"
                + "<td>" + e2b(json.sum.distribution_inject_syringe) + "</td>"
                + "<td>" + e2b(json.sum.closingbalance_inject_syringe) + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + e2b(json.sum.openingbalance_ecp) + "</td>"
                + "<td>" + e2b(json.sum.receiveqty_ecp) + "</td>"
                + "<td>" + e2b(json.sum.current_month_stock_ecp) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_plus_ecp) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_minus_ecp) + "</td>"
                + "<td>" + e2b(json.sum.total_ecp) + "</td>"
                + "<td>" + e2b(json.sum.distribution_ecp) + "</td>"
                + "<td>" + e2b(json.sum.closingbalance_ecp) + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + e2b(json.sum.openingbalance_misoprostol) + "</td>"
                + "<td>" + e2b(json.sum.receiveqty_misoprostol) + "</td>"
                + "<td>" + e2b(json.sum.current_month_stock_misoprostol) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_plus_misoprostol) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_minus_misoprostol) + "</td>"
                + "<td>" + e2b(json.sum.total_misoprostol) + "</td>"
                + "<td>" + e2b(json.sum.distribution_misoprostol) + "</td>"
                + "<td>" + e2b(json.sum.closingbalance_misoprostol) + "</td>"
                + "<td>" + one + "</td>";

    } else if (page == 10) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + e2b(json.sum.openingbalance_chlorhexidine) + "</td>"
                + "<td>" + e2b(json.sum.receiveqty_chlorhexidine) + "</td>"
                + "<td>" + e2b(json.sum.current_month_stock_chlorhexidine) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_plus_chlorhexidine) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_minus_chlorhexidine) + "</td>"
                + "<td>" + e2b(json.sum.total_chlorhexidine) + "</td>"
                + "<td>" + e2b(json.sum.distribution_chlorhexidine) + "</td>"
                + "<td>" + e2b(json.sum.closingbalance_chlorhexidine) + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + e2b(json.sum.openingbalance_mnp) + "</td>"
                + "<td>" + e2b(json.sum.receiveqty_mnp) + "</td>"
                + "<td>" + e2b(json.sum.current_month_stock_mnp) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_plus_mnp) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_minus_mnp) + "</td>"
                + "<td>" + e2b(json.sum.total_mnp) + "</td>"
                + "<td>" + e2b(json.sum.distribution_mnp) + "</td>"
                + "<td>" + e2b(json.sum.closingbalance_mnp) + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + e2b(json.sum.openingbalance_iron) + "</td>"
                + "<td>" + e2b(json.sum.receiveqty_iron) + "</td>"
                + "<td>" + e2b(json.sum.current_month_stock_iron) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_plus_iron) + "</td>"
                + "<td>" + e2b(json.sum.adjustment_minus_iron) + "</td>"
                + "<td>" + e2b(json.sum.total_iron) + "</td>"
                + "<td>" + e2b(json.sum.distribution_iron) + "</td>"
                + "<td>" + e2b(json.sum.closingbalance_iron) + "</td>"
                + "<td>" + one + "</td>";
    }
    return row;
}

function getLastRow8(json, page, car) {
    var row = "", one = "";
    if (page == 1) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + e2b(json.sum.r_unit_capable_elco_tot_2) + "</td>"
                + "<td>" + e2b(json.sum.r_old_pill_3) + "</td>"
                + "<td>" + e2b(json.sum.r_new_pill_4) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_month_pill_5) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_m_left_pill_no_method_6) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_m_left_pill_oth_method_7) + "</td>"
                + "<td>" + e2b(json.sum.r_old_condom_8) + "</td>"
                + "<td>" + e2b(json.sum.r_new_condom_9) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_month_condom_10) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_m_left_condom_no_method_11) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_m_left_condom_oth_method_12) + "</td>"
                + "<td>" + e2b(json.sum.r_old_injectable) + "</td>"
                + "<td>" + e2b(json.sum.r_new_injectable) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_month_injectable) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_m_left_inj_no_method) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_m_left_inj_oth_method) + "</td>"
                + "<td>" + e2b(json.sum.r_old_iud) + "</td>"
                + "<td>" + e2b(json.sum.r_new_iud) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_month_iud) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_m_left_iud_no_method) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_m_left_iud_oth_method) + "</td>"
                + "<td>" + e2b(json.sum.r_old_implant) + "</td>"
                + "<td>" + e2b(json.sum.r_new_implant) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_month_implant) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_m_left_implant_no_method) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_m_left_implant_oth_method) + "</td>"
                + "<td>" + e2b(json.sum.r_old_permanent_man) + "</td>"
                + "<td>" + e2b(json.sum.r_new_permanent_man) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_month_permanent_man) + "</td>"
                + "<td>" + e2b(json.sum.r_old_permanent_woman) + "</td>"
                + "<td>" + e2b(json.sum.r_new_permanent_woman) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_month_permanent_woman) + "</td>"
                + "<td>" + e2b(json.sum.r_sent_method_all_tot) + "</td>"
                + "<td>" + e2b(json.sum.r_sent_side_effect_all_tot) + "</td>"
                + "<td>" + e2b(json.sum.r_unit_all_total) + "</td>"
//                    + "<td>" + e2b(json.avg('r_car').toFixed(2)) + "</td>";
                + "<td>" + car + "</td>";

    } else if (page == 2) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + e2b(json.sum.r_curr_month_preg_new_fwa_38) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_month_preg_old_fwa_39) + "</td>"
                + "<td>" + e2b(json.sum.r_curr_month_preg_tot_fwa_40) + "</td>"
                + "<td>" + e2b(json.sum.r_priv_month_preg_tot_fwa_41) + "</td>"
                + "<td>" + e2b(json.sum.r_unit_preg_tot_fwa1_42) + "</td>"
                + "<td>" + e2b(json.sum.r_preg_anc_service_visit1_fwa_43) + "</td>"
                + "<td>" + e2b(json.sum.r_preg_anc_service_visit2_fwa_44) + "</td>"
                + "<td>" + e2b(json.sum.r_preg_anc_service_visit3_fwa_45) + "</td>"
                + "<td>" + e2b(json.sum.r_preg_anc_service_visit4_fwa_46) + "</td>"
                + "<td>" + e2b(json.sum.r_delivary_service_home_trained_fwa_47) + "</td>"
                + "<td>" + e2b(json.sum.r_delivary_service_home_untrained_fwa_48) + "</td>"
                + "<td>" + e2b(json.sum.r_delivary_service_hospital_normal_fwa_49) + "</td>"
                + "<td>" + e2b(json.sum.r_delivary_service_hospital_cesarean_fwa_50) + "</td>"
                + "<td>" + e2b(json.sum.r_pnc_mother_visit1_fwa_51) + "</td>"
                + "<td>" + e2b(json.sum.r_pnc_mother_visit2_fwa_52) + "</td>"
                + "<td>" + e2b(json.sum.r_pnc_mother_visit3_fwa_53) + "</td>"
                + "<td>" + e2b(json.sum.r_pnc_mother_visit4_fwa_54) + "</td>"
                + "<td>" + e2b(json.sum.r_pnc_newborn_visit1_fwa_55) + "</td>"
                + "<td>" + e2b(json.sum.r_pnc_newborn_visit2_fwa_56) + "</td>"
                + "<td>" + e2b(json.sum.r_pnc_newborn_visit3_fwa_57) + "</td>"
                + "<td>" + e2b(json.sum.r_pnc_newborn_visit4_fwa_58) + "</td>"
                + "<td>" + e2b(json.sum.r_ref_risky_preg_cnt_fwa_59) + "</td>"
                + "<td>" + e2b(json.sum.r_childless_couple_adviced_fwa_60) + "</td>"
                + "<td>" + e2b(json.sum.r_childless_couple_refered_fwa_61) + "</td>"
                + "<td>" + e2b(json.sum.r_tt_women_1st_fwa_62) + "</td>"
                + "<td>" + e2b(json.sum.r_tt_women_2nd_fwa_63) + "</td>"
                + "<td>" + e2b(json.sum.r_tt_women_3rd_fwa_64) + "</td>"
                + "<td>" + e2b(json.sum.r_tt_women_4th_fwa_65) + "</td>"
                + "<td>" + e2b(json.sum.r_tt_women_5th_fwa_66) + "</td>"
                + "<td>" + e2b(json.sum.r_ecp_taken_fwa_67) + "</td>"
                + "<td>" + e2b(json.sum.r_misoprostol_taken_fwa_68) + "</td>"
                + "<td>" + e2b(json.sum.r_health_change_adolescent_fwa_69) + "</td>"
                + "<td>" + e2b(json.sum.r_child_marriage_preg_disadvantage_fwa_70) + "</td>"
                + "<td>" + e2b(json.sum.r_iron_folic_acid_fwa_71) + "</td>"
                + "<td>" + e2b(json.sum.r_sexual_disease_fwa_72) + "</td>";
    } else if (page == 3) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + e2b(json.sum.r_satelite_clinic_presence_fwa_73) + "</td>"
                + "<td>" + e2b(json.sum.r_epi_session_presence_fwa_74) + "</td>"
                + "<td>" + e2b(json.sum.r_community_clinic_presence_fwa_75) + "</td>"
                + "<td>" + e2b(json.sum.r_newborn_1min_washed_fwa_76) + "</td>"
                + "<td>" + e2b(json.sum.r_newborn_71_chlorohexidin_used_fwa_77) + "</td>"
                + "<td>" + e2b(json.sum.r_vaccin_child_bcg_fwa_78) + "</td>"
                + "<td>" + e2b(json.sum.r_vaccin_0_18_months_opv_pcv_1_fwa_79) + "</td>"
                + "<td>" + e2b(json.sum.r_vaccin_0_18_months_opv_pcv_2_fwa_80) + "</td>"
                + "<td>" + e2b(json.sum.r_vaccin_0_18_months_opv_3_fwa_81) + "</td>"
                + "<td>" + e2b(json.sum.r_vaccin_0_18_months_pcv3_fwa_82) + "</td>"
                + "<td>" + e2b(json.sum.r_vaccin_0_18_months_mr_opv4_fwa_83) + "</td>"
                + "<td>" + e2b(json.sum.r_vaccin_0_18_ham_fwa_84) + "</td>"
                + "<td>" + e2b(json.sum.r_referred_child_dangerous_disease_fwa_85) + "</td>"
                + "<td>" + e2b(json.sum.r_referred_child_neumonia_fwa_86) + "</td>"
                + "<td>" + e2b(json.sum.r_referred_child_diahoea_fwa_87) + "</td>"
                + "<td>" + e2b(json.sum.r_tot_live_birth_fwa_88) + "</td>"
                + "<td>" + e2b(json.sum.r_less_weight_birth_fwa_89) + "</td>"
                + "<td>" + e2b(json.sum.r_immature_birth_less37weeks_fwa_90) + "</td>"
                + "<td>" + e2b(json.sum.r_still_birth_fwa_91) + "</td>"
                + "<td>" + e2b(json.sum.r_death_less_1yr_0_7days_fwa_92) + "</td>"
                + "<td>" + e2b(json.sum.r_death_less_1yr_8_28days_fwa_93) + "</td>"
                + "<td>" + e2b(json.sum.r_death_less_1yr_29dys_less1yr_fwa_94) + "</td>"
                + "<td>" + e2b(json.sum.r_death_less_1yr_tot_fwa_95) + "</td>"
                + "<td>" + e2b(json.sum.r_death_1yr_less_5yr_fwa_96) + "</td>"
                + "<td>" + e2b(json.sum.r_death_maternal_death_fwa_97) + "</td>"
                + "<td>" + e2b(json.sum.r_death_other_fwa_98) + "</td>"
                + "<td>" + e2b(json.sum.r_death_all_fwa_99) + "</td>";
    } else if (page == 4) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + e2b(json.sum.r_iron_folic_extrafood_counsil_preg_woman_100) + "</td>"
                + "<td>" + e2b(json.sum.r_iron_folic_extrafood_counsil_mother_0to23m_101) + "</td>"
                + "<td>" + e2b(json.sum.r_iron_folic_pill_distribute_preg_woman_102) + "</td>"
                + "<td>" + e2b(json.sum.r_iron_folic_pill_distribute_mother_0to23m_103) + "</td>"
                + "<td>" + e2b(json.sum.r_bfeeding_comp_food_counsil_preg_woman_104) + "</td>"
                + "<td>" + e2b(json.sum.r_bfeeding_comp_food_counsil_mother_0to23m_105) + "</td>"
                + "<td>" + e2b(json.sum.r_child_mnp_feeding_mother_0to23m_106) + "</td>"
                + "<td>" + e2b(json.sum.r_birth_1hr_bfeed_0_less_6mon_107) + "</td>"
                + "<td>" + e2b(json.sum.r_birth_only_bfeed_0_less_6mon_108) + "</td>"
                + "<td>" + e2b(json.sum.r_child_afood_6_less24mon_109) + "</td>"
                + "<td>" + e2b(json.sum.r_child_afood_24_less60mon_110) + "</td>"
                + "<td>" + e2b(json.sum.r_mnp_given_6_less24mon_111) + "</td>"
                + "<td>" + e2b(json.sum.r_mam_child_0_less_6mon_112) + "</td>"
                + "<td>" + e2b(json.sum.r_mam_child_6_less_24mon_113) + "</td>"
                + "<td>" + e2b(json.sum.r_mam_child_24_less_60mon_114) + "</td>"
                + "<td>" + e2b(json.sum.r_sam_child_0_less_6mon_115) + "</td>"
                + "<td>" + e2b(json.sum.r_sam_child_6_less_24mon_116) + "</td>"
                + "<td>" + e2b(json.sum.r_sam_child_24_less_60mon_117) + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>";
    } else if (page == 5) {
        row = "<td><span class='r-v'>সর্বমোট</span></td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>";
    } else if (page == 6) {
        row = "<td colspan='11'>সর্বমোট</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>"
                + "<td>" + one + "</td>";
    }
    return row;
}